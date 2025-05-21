require "optparse"

module BuilderBase
  module Cli
    class Options
      include Logging

      DEFAULT_STUDIO_TYPE = "studio_pro".freeze

      STUDIO_TYPES = {
        "studio_pro" => :studio_pro,
        "studio_store" => :studio_store
      }

      attr_accessor :studio_type, :rails_version

      class << self
        def parse(args:, env: ENV)
          options = Options.new(env: env)
          options.parse!(args)
          options
        rescue OptionParser::ParseError => e
          error(e.message)
          exit(1)
        end
      end

      def initialize(env: ENV)
        self.studio_type = studio_type_from_env_or_default(env)
        self.rails_version = nil
      end

      def parse!(args)
        parser.parse!(args)
      end

      private

      def parser
        OptionParser.new do |opts|
          opts.banner = "Usage: create_builder_app [options]"

          opts.on("-t", "--studio-type [TYPE]", "Studio type (studio_pro or studio_store)") do |studio_type|
            self.studio_type = fetch_valid_studio_type(studio_type)
          end

          opts.on("-v", "--rails-version [VERSION]", "Rails version (e.g., 6.1.7)") do |rails_version|
            self.rails_version = rails_version
          end
        end
      end

      def studio_type_from_env_or_default(env)
        studio_type = env.fetch("STUDIO_TYPE", DEFAULT_STUDIO_TYPE)
        fetch_valid_studio_type(studio_type)
      end

      def fetch_valid_studio_type(studio_type)
        STUDIO_TYPES.fetch(studio_type) do
          raise OptionParser::InvalidArgument.new("Invalid studio type: #{studio_type}. Valid types are: #{STUDIO_TYPES.keys.join(", ")}")
        end
      end
    end
  end
end
