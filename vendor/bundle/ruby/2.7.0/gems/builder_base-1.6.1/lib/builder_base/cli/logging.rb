require_relative "../cli"

module BuilderBase
  module Cli
    module Logging
      def self.included(base)
        base.extend(self)
      end

      def debug(message)
        logger.debug(progname) { message }
      end

      def info(message)
        logger.info(progname) { message }
      end

      def error(message)
        logger.error(progname) { message }
      end

      def logger
        BuilderBase::Cli.logger
      end

      def progname
        self.class.name.gsub("BuilderBase::Cli::", "")
      end
    end
  end
end
