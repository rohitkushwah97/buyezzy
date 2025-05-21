class CreateBxBuilderChainSchema < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'vector' unless extension_enabled?('vector')

    # bx_builder_chain_embeddings table
    create_table :bx_builder_chain_embeddings do |t|
      t.text :content
      t.column :vectors, "vector(1536)"
      t.text :namespace, default: 'public'
      
      t.index :namespace
    end

    # bx_builder_chain_documents table
    create_table :bx_builder_chain_documents do |t|
      t.text :name
      t.text :namespace, default: 'public'
      
      t.index [:name, :namespace], unique: true
      t.index :namespace
      t.timestamps
    end

    # bx_builder_chain_document_chunks table
    create_table :bx_builder_chain_document_chunks do |t|
      t.references :document, null: false, foreign_key: { to_table: :bx_builder_chain_documents, on_delete: :cascade }
      t.references :embedding, null: false, foreign_key: { to_table: :bx_builder_chain_embeddings, on_delete: :cascade }
    end

    # Unique constraint for combination of document_id and embedding_id
    add_index :bx_builder_chain_document_chunks, [:document_id, :embedding_id], unique: true, name: 'index_document_embedding_unique'
  end
end
