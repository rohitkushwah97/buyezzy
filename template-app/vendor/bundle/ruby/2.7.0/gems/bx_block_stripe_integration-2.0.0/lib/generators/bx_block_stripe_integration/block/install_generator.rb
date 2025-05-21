# frozen_string_literal: true

require "builder_base/generators/install/base"

module BxBlockStripeIntegration
  module Block
    class InstallGenerator < BuilderBase::Generators::Install::Base
      set_file_directory __dir__

      source_root File.expand_path("templates", __dir__)

      def execute
        super

        add_templates
      end

      def add_templates
        directory "config", "config", force: true
      end
    end
  end
end
