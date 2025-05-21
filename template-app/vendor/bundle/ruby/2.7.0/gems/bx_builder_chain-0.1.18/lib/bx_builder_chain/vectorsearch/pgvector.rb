# frozen_string_literal: true

module BxBuilderChain::Vectorsearch
  class Pgvector < Base
    #
    # The PostgreSQL vector search adapter
    #
    # Usage:
    # pgvector = Langchain::Vectorsearch::Pgvector.new(url:, table_name:, llm:, namespace: nil)
    #

    # The operators supported by the PostgreSQL vector search adapter
    OPERATORS = {
      "cosine_distance" => "cosine",
      "euclidean_distance" => "euclidean"
    }
    DEFAULT_OPERATOR = "cosine_distance"

    attr_reader :db, :operator, :table_name, :namespace_column, :namespaces, :documents_table

    # @param url [String] The URL of the PostgreSQL database
    # @param table_name [String] The name of the table to use for the index
    # @param llm [Object] The LLM client to use
    # @param namespace [String] The namespace to use for the index when inserting/querying
    def initialize(llm:, namespaces: [BxBuilderChain.configuration.public_namespace] || ['public'])
      depends_on "sequel"
      require "sequel"
      
      @db = create_sequel_connection
      @table_name = "bx_builder_chain_embeddings"
      @namespace_column = "namespace"
      set_namespaces(namespaces)
      @threshold = BxBuilderChain.configuration.threshold

      validate_threshold(@threshold)

      @operator = OPERATORS[DEFAULT_OPERATOR]

      super(llm: llm)
    end

    def documents_model
      Class.new(Sequel::Model(@table_name.to_sym)) do
        plugin :pgvector, :vectors
      end
    end

    # Upsert a list of texts to the index
    # @param texts [Array<String>] The texts to add to the index
    # @param ids [Array<Integer>] The ids of the objects to add to the index, in the same order as the texts
    # @return [PG::Result] The response from the database including the ids of
    # the added or updated texts.
    def upsert_texts(texts:, ids:)
      data = texts.zip(ids).flat_map do |(text, id)|
        {id: id, content: text, vectors: llm.embed(text: text).to_s, namespace: namespaces[0]}
      end
      # @db[table_name.to_sym].multi_insert(data, return: :primary_key)
      @db[@table_name.to_sym]
        .insert_conflict(
          target: :id,
          update: {content: Sequel[:excluded][:content], vectors: Sequel[:excluded][:vectors]}
        )
        .multi_insert(data, return: :primary_key)
    end

    # Add a list of texts to the index
    # @param texts [Array<String>] The texts to add to the index
    # @param ids [Array<String>] The ids to add to the index, in the same order as the texts
    # @return [Array<Integer>] The the ids of the added texts.
    def add_texts(texts:, ids: nil)
      if ids.nil? || ids.empty?
        mutex = Mutex.new
        texts.each_slice(10).flat_map do |text_batch|  # Process in batches of 10
          data = []
          Async do |parent|
            text_batch.map do |text|
              parent.async do |task|
                begin
                  vectorised_text = {content: text, vectors: llm.embed(text: text).to_s, namespace: namespaces[0]}
                  mutex.synchronize do
                    data << vectorised_text
                  end
                rescue => e
                  puts "Error processing text: #{e.message}"
                  nil  # or some error indication
                end
              end
            end # Ensure all tasks in the batch are completed
          end.wait
          @db[@table_name.to_sym].multi_insert(data, return: :primary_key)
        end        
      else
        upsert_texts(texts: texts, ids: ids)
      end
    end

    # Update a list of ids and corresponding texts to the index
    # @param texts [Array<String>] The texts to add to the index
    # @param ids [Array<String>] The ids to add to the index, in the same order as the texts
    # @return [Array<Integer>] The ids of the updated texts.
    def update_texts(texts:, ids:)
      upsert_texts(texts: texts, ids: ids)
    end

    def create_default_schema
      db.run "CREATE EXTENSION IF NOT EXISTS vector"
      
      namespace_column = @namespace_column
      vector_dimension = llm.default_dimension || 1000
      
      # bx_builder_chain_embeddings table
      db.create_table? :bx_builder_chain_embeddings do
        primary_key :id
        text :content
        column :vectors, "vector(#{vector_dimension})"
        text namespace_column.to_sym, default: 'public'
        
        index namespace_column.to_sym
      end
    
      # bx_builder_chain_documents table
      db.create_table? :bx_builder_chain_documents do
        primary_key :id
        text :name
        text namespace_column.to_sym, default: 'public'
        timestamp :created_at
        timestamp :updated_at
        
        index [:name, namespace_column.to_sym], unique: true
      end
      
      # bx_builder_chain_document_chunks table
      db.create_table? :bx_builder_chain_document_chunks do
        primary_key :id
        foreign_key :document_id, :bx_builder_chain_documents, null: false, on_delete: :cascade
        foreign_key :embedding_id, :bx_builder_chain_embeddings, null: false, on_delete: :cascade
    
        unique [:document_id, :embedding_id]
      end
    end
    

    # Destroy default schema
    def destroy_default_schema
      db.drop_table? :bx_builder_chain_document_chunks
      db.drop_table? :bx_builder_chain_documents
      db.drop_table? :bx_builder_chain_embeddings
    end

    # Search for similar texts in the index
    # @param query [String] The text to search for
    # @param k [Integer] The number of top results to return
    # @return [Array<Hash>] The results of the search
    def similarity_search(query:, k: 4)
      embedding = llm.embed(text: query)

      similarity_search_by_vector(
        embedding: embedding,
        k: k
      )
    end

    # Search for similar texts in the index by the passed in vector.
    # You must generate your own vector using the same LLM that generated the embeddings stored in the Vectorsearch DB.
    # @param embedding [Array<Float>] The vector to search for
    # @param k [Integer] The number of top results to return
    # @return [Array<Hash>] The results of the search
    def similarity_search_by_vector(embedding:, k: 4)
      db.transaction do # BEGIN
        documents_model
          .nearest_neighbors(:vectors, embedding, distance: operator, threshold: @threshold)
          .where(@namespace_column.to_sym => namespaces)
          .limit(k)
      end
    end

    # Ask a question and return the answer
    # @param question [String] The question to ask
    # @return [String] The answer to the question
    def ask(question:, context_results: 4, prompt_template: nil)
      search_results = similarity_search(query: question, k: context_results)

      context = search_results.map do |result|
        result.content.to_s
      end
      context = context.join("\n---\n")

      prompt = generate_prompt(question: question, context: context, prompt_template: nil)

      llm.chat(prompt: prompt)
    end

    def add_data(paths:)
      raise ArgumentError, "Paths must be provided" if Array(paths).empty?

      all_added_chunk_ids = []

      @db.transaction do  # Start the transaction
        paths.each do |file_n_path|
          path, file = extract_path_and_file(file_n_path)

          texts = BxBuilderChain::Loader.new(path)&.load&.chunks.map { |chunk| chunk[:text] }
          
          texts.flatten!

          added_chunk_ids_for_current_path = add_texts(texts: texts)
          
          all_added_chunk_ids.concat(added_chunk_ids_for_current_path)
    
          document_record_id = @db[:bx_builder_chain_documents].insert(
                                                                  name: file, 
                                                                  namespace: namespaces[0],
                                                                  created_at: Time.now.utc,
                                                                  updated_at: Time.now.utc
                                                                )
    
          document_chunks_data = added_chunk_ids_for_current_path.map do |chunk_id|
            {document_id: document_record_id, embedding_id: chunk_id}
          end
          @db[:bx_builder_chain_document_chunks].multi_insert(document_chunks_data)
        end
      end  # End the transaction

      all_added_chunk_ids
    end

    private 

    def extract_path_and_file(entry)
      entry.is_a?(Hash) ? [entry[:path], entry[:filename]] : [entry, entry]
    end

    def validate_threshold(threshold)
      raise "Threshold must be between 0.0 and 2.0 (0.0 being a perfect match) or nil (ignore threshold)" if !threshold.nil? && (threshold > 2 || threshold < 0)
    end

    def set_namespaces(namespaces)
      namespaces = [namespaces] unless namespaces.is_a?(Array)
      @namespaces = namespaces.push(BxBuilderChain.configuration.public_namespace).uniq  
    end    
    
    def create_sequel_connection
      config = BxBuilderChain.configuration

      if config.pg_url
        Sequel.connect(config.pg_url)
      else
        Sequel.connect(
          adapter: 'postgres',
          host: config.database_host,
          database: config.database_name,
          user: config.database_user,
          password: config.database_password,
          port: config.database_port
        )
      end
    end
  end
end
