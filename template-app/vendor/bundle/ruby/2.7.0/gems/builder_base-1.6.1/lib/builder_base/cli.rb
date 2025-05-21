require "logger"

module BuilderBase
  module Cli
    class << self
      attr_writer :logger

      def logger
        @logger ||= Logger.new($stdout).tap do |logger|
          logger.level = Logger::INFO
        end
      end
    end
  end
end
