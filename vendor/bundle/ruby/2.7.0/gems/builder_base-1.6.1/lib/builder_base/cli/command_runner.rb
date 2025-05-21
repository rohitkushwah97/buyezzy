require_relative "logging"

module BuilderBase
  module Cli
    class CommandRunner
      include Logging

      class << self
        def run(command, command_args = [], env_vars = {})
          new(command, command_args, env_vars).run
        end
      end

      attr_reader :stdout_str, :stderr_str, :status

      def initialize(command, command_args = [], env_vars = {})
        @command = command
        @command_args = Array(command_args)
        @env_vars = env_vars
      end

      def run
        info("cwd: #{Dir.pwd}")
        info("executing: `#{env_vars_str} #{command_with_args.join(" ")}`")

        @stdout_str, @stderr_str, @status = Open3.capture3(@env_vars, *command_with_args)

        info("exitstatus: #{status.exitstatus}")

        debug(stdout_str)
        error(stderr_str) unless stderr_str.empty?

        self
      end

      def success?
        status&.success?
      end

      private

      def command_with_args
        [@command] + @command_args
      end

      def env_vars_str
        @env_vars.map { |k, v| "#{k}=#{v}" }.join(" ")
      end
    end
  end
end
