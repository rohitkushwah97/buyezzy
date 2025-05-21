# frozen_string_literal: true

module BxBuilderChain
  module Processors
    class Docx < Base
      EXTENSIONS = [".docx"]
      CONTENT_TYPES = ["application/vnd.openxmlformats-officedocument.wordprocessingml.document"]

      def initialize(*)
        depends_on "docx"
        require "docx"
      end

      # Parse the document and return the text
      # @param [File] data
      # @return [String]
      def parse(data)
        ::Docx::Document
          .open(StringIO.new(data.read))
          .text
          .strip
      end
    end
  end
end
