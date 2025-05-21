# frozen_string_literal: true

require "baran"

module BxBuilderChain
  module Chunker
    #
    # Recursive text chunker. Preferentially splits on separators.
    #
    # Usage:
    #     BxBuilderChain::Chunker::RecursiveText.new(text).chunks
    #
    class RecursiveText
      attr_reader :text, :chunk_size, :chunk_overlap, :separators

      # @param [String] text
      # @param [Integer] chunk_size
      # @param [Integer] chunk_overlap
      # @param [Array<String>] separators
      def initialize(text, chunk_size: 1000, chunk_overlap: 200, separators: ["\n\n", "\n", ".", " ", ""])
        @text = text
        @chunk_size = chunk_size
        @chunk_overlap = chunk_overlap
        @separators = separators
      end

      # @return [Array<String>]
      def chunks
        splitter = Baran::RecursiveCharacterTextSplitter.new(
          chunk_size: chunk_size,
          chunk_overlap: chunk_overlap,
          separators: separators
        )
        splitter.chunks(text)
      end
    end
  end
end
