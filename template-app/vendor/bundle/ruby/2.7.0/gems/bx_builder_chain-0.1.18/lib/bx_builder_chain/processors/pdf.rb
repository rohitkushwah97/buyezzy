# frozen_string_literal: true

module BxBuilderChain
  module Processors
    class Pdf < Base
      EXTENSIONS = [".pdf"]
      CONTENT_TYPES = ["application/pdf"]

      def initialize(*)
        depends_on "pdf-reader"
        require "pdf-reader"
      end

      # Parse the document and return the text
      # @param [File] data
      # @return [String]
      def parse(data)
        ::PDF::Reader
          .new(StringIO.new(data.read))
          .pages
          .map(&:text)
          .join("\n\n")
      end
    end
  end
end
