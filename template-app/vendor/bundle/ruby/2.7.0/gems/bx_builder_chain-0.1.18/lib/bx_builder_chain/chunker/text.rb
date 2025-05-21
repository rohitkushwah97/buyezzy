# frozen_string_literal: true

require "baran"

module BxBuilderChain
  module Chunker
    #
    # Simple text chunker
    #
    # Usage:
    #     BxBuilderChain::Chunker::Text.new(text).chunks
    #
    class Text
      attr_reader :text, :chunk_size, :chunk_overlap, :separator

      # @param [String] text
      # @param [Integer] chunk_size
      # @param [Integer] chunk_overlap
      # @param [String] separator
      def initialize(text, chunk_size: 1024, chunk_overlap: 64, separator: "\n\n")
        @text = text
        @chunk_size = chunk_size
        @chunk_overlap = chunk_overlap
        @separator = separator
      end

      # @return [Array<String>]
      def chunks
        splitter = Baran::CharacterTextSplitter.new(
          chunk_size: chunk_size,
          chunk_overlap: chunk_overlap,
          separator: separator
        )
        splitter.chunks(text)
      end
    end
  end
end
