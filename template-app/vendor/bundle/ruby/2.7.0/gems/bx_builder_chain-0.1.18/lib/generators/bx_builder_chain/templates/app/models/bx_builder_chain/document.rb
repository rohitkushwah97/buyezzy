module BxBuilderChain
  class Document < ::ApplicationRecord
    self.table_name = "bx_builder_chain_documents"
    
    has_many :document_chunks, class_name: 'BxBuilderChain::DocumentChunk'
    has_many :embeddings, through: :document_chunks
    
    before_destroy :destroy_associated_data
    after_update :update_associated_embedding_namespaces, if: :saved_change_to_namespace?
    
    validates :name, uniqueness: { scope: :namespace, message: "and namespace combination already exists" }

    private

    def update_associated_embedding_namespaces
      embeddings.update_all(namespace: namespace)
    end

    def destroy_associated_data
      # Delete all associated embeddings without loading them into memory
      embedding_ids = BxBuilderChain::DocumentChunk.where(document_id: id).pluck(:embedding_id)
      BxBuilderChain::Embedding.where(id: embedding_ids).delete_all

      # Delete all chunks without loading them
      BxBuilderChain::DocumentChunk.where(document_id: id).delete_all
    end
  end
end
