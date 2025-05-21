module BxBuilderChain
    class Embedding < ::ApplicationRecord
      self.table_name = "bx_builder_chain_embeddings"
      
      has_many :document_chunks, class_name: 'BxBuilderChain::DocumentChunk', dependent: :destroy
      has_many :documents, through: :document_chunks
    end
  end
  