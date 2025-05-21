# frozen_string_literal: true

module BxBuilderChain
  module Processors
    class Json < Base
      EXTENSIONS = [".json"]
      CONTENT_TYPES = ["application/json"]

      # Parse the document and return the text
      # @param [File] data
      # @return [Hash]
      def parse(data)
        ::JSON.parse(data.read)
      end
    end
  end
end
