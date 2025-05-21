# frozen_string_literal: true

require "logger"
require 'dotenv'
require "zeitwerk"
require "async"
require_relative 'bx_builder_chain/configuration'

Dotenv.load
loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/bx_builder_chain.rb")
loader.ignore("#{__dir__}/bx_builder_chain/configuration.rb")
loader.ignore("#{__dir__}/generators")
loader.setup

module BxBuilderChain
  class << self
    attr_reader :logger
    attr_writer :configuration

    def logger=(logger)
      @logger ||= logger
    end
    
    def configuration
      @configuration ||= Configuration.new
    end
  
    def configure
      yield(configuration)
    end

    def reset_config
      @configuration = Configuration.new
    end
  end

  self.logger = ::Logger.new($stdout, level: :warn)

  class Error < StandardError; end

end
