# frozen_string_literal: true

module BxBuilderChain
  # Abstraction for data loaded by a {BxBuilderChain::Loader}
  class Data
    # URL or Path of the data source
    # @return [String]
    attr_reader :source

    # @param data [String] data that was loaded
    # @option options [String] :source URL or Path of the data source
    def initialize(data, options = {})
      @source = options[:source]
      @data = data
    end

    # @return [String]
    def value
      @data
    end

    # @param opts [Hash] options passed to the chunker
    # @return [Array<String>]
    def chunks(opts = {})
      BxBuilderChain::Chunker::RecursiveText.new(@data, **opts).chunks
    end
  end
end
