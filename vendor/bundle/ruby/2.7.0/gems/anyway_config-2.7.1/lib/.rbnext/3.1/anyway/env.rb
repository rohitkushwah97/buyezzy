# frozen_string_literal: true

module Anyway
  # Parses environment variables and provides
  # method-like access
  class Env
    using RubyNext
    using Anyway::Ext::DeepDup
    using Anyway::Ext::Hash

    class << self
      def from_hash(hash, prefix: nil, memo: {})
        hash.each do |key, value|
          prefix_with_key = (prefix && !prefix.empty?) ? "#{prefix}_#{key.to_s.upcase}" : key.to_s.upcase

          if value.is_a?(Hash)
            from_hash(value, prefix: "#{prefix_with_key}_", memo: memo)
          else
            memo[prefix_with_key] = value.to_s
          end
        end

        memo
      end
    end

    include Tracing

    attr_reader :data, :traces, :type_cast, :env_container

    def initialize(type_cast: AutoCast, env_container: ENV)
      @type_cast = type_cast
      @data = {}
      @traces = {}
      @env_container = env_container
    end

    def clear
      data.clear
      traces.clear
    end

    def fetch(prefix)
      return data[prefix].deep_dup if data.key?(prefix)

      Tracing.capture do
        data[prefix] = parse_env(prefix)
      end.then do |trace|
        traces[prefix] = trace
      end

      data[prefix].deep_dup
    end

    def fetch_with_trace(prefix)
      [fetch(prefix), traces[prefix]]
    end

    private

    def parse_env(prefix)
      match_prefix = prefix.empty? ? prefix : "#{prefix}_"
      env_container.each_pair.with_object({}) do |(key, val), data|
        next unless key.start_with?(match_prefix)

        path = key.sub(/^#{match_prefix}/, "").downcase

        paths = path.split("__")
        trace!(:env, *paths, key: key) { data.bury(type_cast.call(val), *paths) }
      end
    end
  end
end
