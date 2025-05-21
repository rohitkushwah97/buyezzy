# frozen_string_literal: true

module BxBuilderChain::Vectorsearch
  # = Vector Databases
  # A vector database a type of database that stores data as high-dimensional vectors, which are mathematical representations of features or attributes. Each vector has a certain number of dimensions, which can range from tens to thousands, depending on the complexity and granularity of the data.
  #
  # == Available vector databases
  #
  # - {BxBuilderChain::Vectorsearch::Pgvector}
  #
  # == Usage
  #
  # 1. Pick a vector database from list.
  # 2. Review its documentation to install the required gems, and create an account, get an API key, etc
  # 3. Instantiate the vector database class:
  #
  #     weaviate = BxBuilderChain::Vectorsearch::Weaviate.new(
  #       url:         ENV["WEAVIATE_URL"],
  #       api_key:     ENV["WEAVIATE_API_KEY"],
  #       table_name:  "Documents",
  #       llm:         :openai,              # or :cohere, :hugging_face, :google_palm, or :replicate
  #       llm_api_key: ENV["OPENAI_API_KEY"] # API key for the selected LLM
  #     )
  #
  #     # You can instantiate other supported vector databases the same way:
  #     milvus   = BxBuilderChain::Vectorsearch::Milvus.new(...)
  #     qdrant   = BxBuilderChain::Vectorsearch::Qdrant.new(...)
  #     pinecone = BxBuilderChain::Vectorsearch::Pinecone.new(...)
  #     chrome   = BxBuilderChain::Vectorsearch::Chroma.new(...)
  #     pgvector = BxBuilderChain::Vectorsearch::Pgvector.new(...)
  #
  # == Schema Creation
  #
  # `create_default_schema()` creates default schema in your vector database.
  #
  #     search.create_default_schema
  #
  # (We plan on offering customizable schema creation shortly)
  #
  # == Adding Data
  #
  # You can add data with:
  # 1. `add_data(path:, paths:)` to add any kind of data type
  #
  #     my_pdf = BxBuilderChain.root.join("path/to/my.pdf")
  #     my_text = BxBuilderChain.root.join("path/to/my.txt")
  #     my_docx = BxBuilderChain.root.join("path/to/my.docx")
  #     my_csv = BxBuilderChain.root.join("path/to/my.csv")
  #
  #     search.add_data(paths: [my_pdf, my_text, my_docx, my_csv])
  #
  # 2. `add_texts(texts:)` to only add textual data
  #
  #     search.add_texts(
  #       texts: [
  #         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  #         "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
  #       ]
  #     )
  #
  # == Retrieving Data
  #
  # `similarity_search_by_vector(embedding:, k:)` searches the vector database for the closest `k` number of embeddings.
  #
  #    search.similarity_search_by_vector(
  #      embedding: ...,
  #      k: # number of results to be retrieved
  #    )
  #
  # `vector_store.similarity_search(query:, k:)` generates an embedding for the query and searches the vector database for the closest `k` number of embeddings.
  #
  # search.similarity_search_by_vector(
  #   embedding: ...,
  #   k: # number of results to be retrieved
  # )
  #
  # `ask(question:)` generates an embedding for the passed-in question, searches the vector database for closest embeddings and then passes these as context to the LLM to generate an answer to the question.
  #
  #     search.ask(question: "What is lorem ipsum?")
  #
  class Base
    include BxBuilderChain::DependencyHelper

    attr_reader :client, :table_name, :llm

    DEFAULT_METRIC = "cosine"

    # @param llm [Object] The LLM client to use
    def initialize(llm:)
      @llm = llm
    end

    # Method supported by Vectorsearch DB to retrieve a default schema
    def get_default_schema
      raise NotImplementedError, "#{self.class.name} does not support retrieving a default schema"
    end

    # Method supported by Vectorsearch DB to create a default schema
    def create_default_schema
      raise NotImplementedError, "#{self.class.name} does not support creating a default schema"
    end

    # Method supported by Vectorsearch DB to delete the default schema
    def destroy_default_schema
      raise NotImplementedError, "#{self.class.name} does not support deleting a default schema"
    end

    # Method supported by Vectorsearch DB to add a list of texts to the index
    def add_texts(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support adding texts"
    end

    # Method supported by Vectorsearch DB to update a list of texts to the index
    def update_texts(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support updating texts"
    end

    # Method supported by Vectorsearch DB to search for similar texts in the index
    def similarity_search(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support similarity search"
    end

    # Method supported by Vectorsearch DB to search for similar texts in the index by the passed in vector.
    # You must generate your own vector using the same LLM that generated the embeddings stored in the Vectorsearch DB.
    def similarity_search_by_vector(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support similarity search by vector"
    end

    # Method supported by Vectorsearch DB to answer a question given a context (data) pulled from your Vectorsearch DB.
    def ask(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support asking questions"
    end

    def generate_prompt(question:, context:, prompt_template: nil)
      template = prompt_template || BxBuilderChain.configuration.default_prompt_template
      template % {context: context, question: question}
    end

    def add_data(paths:)
      raise ArgumentError, "Paths must be provided" if Array(paths).empty?

      texts = Array(paths)
        .flatten
        .map do |path|
          data = BxBuilderChain::Loader.new(path)&.load&.chunks
          data.map { |chunk| chunk[:text] }
        end

      texts.flatten!

      add_texts(texts: texts)
    end

    def self.logger_options
      {
        color: :blue
      }
    end
  end
end
