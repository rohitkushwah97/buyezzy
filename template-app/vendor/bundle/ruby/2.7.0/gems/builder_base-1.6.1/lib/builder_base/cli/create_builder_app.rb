require "open3"

require_relative "../rails_version"
require_relative "command_runner"
require_relative "logging"
require_relative "options"

module BuilderBase
  module Cli
    class CreateBuilderApp
      include Logging

      class Error < StandardError; end

      class << self
        def execute(options:)
          new(options: options).execute
        rescue Error => e
          error(e.message)
          exit(1)
        end
      end

      def initialize(options:)
        @options = options
      end

      def execute
        ensure_rails_version_is_supported
        ensure_rails_version_installed
        create_new_rails_app
      end

      def ensure_rails_version_is_supported
        return if RailsVersion.supported?(rails_version)

        raise Error, "Requested rails version is not supported. Must be between #{RailsVersion.minimum} and #{RailsVersion.maximum}"
      end

      def ensure_rails_version_installed
        install_rails_version unless rails_version_installed?
      end

      def rails_version_installed?
        gem_list = CommandRunner.run("gem", %W[list -i rails --version #{rails_version}])
        gem_list.success?
      end

      def install_rails_version
        info "Installing Rails #{rails_version}"
        gem_install = CommandRunner.run("gem", %W[install rails -v #{rails_version}])
        raise Error.new("Failed to install Rails") unless gem_install.success?
      end

      def create_new_rails_app
        rails_new = CommandRunner.run("rails",
          [
            "_#{rails_version}_",
            "new",
            ".",
            "--skip-spring",
            "--skip-listen",
            "--skip-turbolinks",
            "--api",
            "--skip-test",
            "--skip-bootsnap",
            "--skip-webpack-install",
            "--skip-action-cable",
            "-d",
            "postgresql"
          ],
          {"RUBYOPT" => "-rlogger"})
        raise Error.new("Failed to create Rails app") unless rails_new.success?
      end

      def rails_version
        @options.rails_version || BuilderBase::RailsVersion.for_new_apps(studio_type: @options.studio_type)
      end
    end
  end
end
