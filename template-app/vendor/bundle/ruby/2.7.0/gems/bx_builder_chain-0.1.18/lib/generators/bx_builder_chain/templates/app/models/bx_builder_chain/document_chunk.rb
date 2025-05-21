module BxBuilderChain
    class DocumentChunk < ::ApplicationRecord
      self.table_name = "bx_builder_chain_document_chunks"
      
      belongs_to :document, class_name: 'BxBuilderChain::Document'
      belongs_to :embedding, class_name: 'BxBuilderChain::Embedding'
    end
  end
  