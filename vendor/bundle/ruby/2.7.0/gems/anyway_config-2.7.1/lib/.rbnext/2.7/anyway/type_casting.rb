# frozen_string_literal: true
using RubyNext;
module Anyway
  # Contains a mapping between type IDs/names and deserializers
  class TypeRegistry
    class << self
      def default
        @default ||= TypeRegistry.new
      end
    end

    def initialize
      @registry = {}
    end

    def accept(name_or_object, &block)
      if !block && !name_or_object.respond_to?(:call)
        raise ArgumentError, "Please, provide a type casting block or an object implementing #call(val) method"
      end

      registry[name_or_object] = block || name_or_object
    end

    def deserialize(raw, type_id, array: false)
      return if raw.nil?

      caster =
        if type_id.is_a?(Symbol) || type_id.nil?
          registry.fetch(type_id) { raise ArgumentError, "Unknown type: #{type_id}" }
        else
          raise ArgumentError, "Type must implement #call(val): #{type_id}" unless type_id.respond_to?(:call)
          type_id
        end

      if array
        raw_arr = raw.is_a?(String) ? raw.split(/\s*,\s*/) : Array(raw)
        raw_arr.map { |_1| it = _1;caster.call(it) }
      else
        caster.call(raw)
      end
    end

    def dup
      new_obj = self.class.allocate
      new_obj.instance_variable_set(:@registry, registry.dup)
      new_obj
    end

    private

    attr_reader :registry
  end

  TypeRegistry.default.tap do |obj|
    obj.accept(nil, &:itself)
    obj.accept(:string, &:to_s)
    obj.accept(:integer, &:to_i)
    obj.accept(:float, &:to_f)

    obj.accept(:date) do |_1|
      require "date" unless defined?(::Date)

      next _1 if _1.is_a?(::Date)

      next _1.to_date if _1.respond_to?(:to_date)

      ::Date.parse(_1)
    end

    obj.accept(:datetime) do |_1|
      require "date" unless defined?(::Date)

      next _1 if _1.is_a?(::DateTime)

      next _1.to_datetime if _1.respond_to?(:to_datetime)

      ::DateTime.parse(_1)
    end

    obj.accept(:uri) do |_1|
      require "uri" unless defined?(::URI)

      next _1 if _1.is_a?(::URI)

      ::URI.parse(_1)
    end

    obj.accept(:boolean) do |_1|
      _1.to_s.match?(/\A(true|t|yes|y|1)\z/i)
    end

    obj.accept(:integer!) do |_1|
      Integer(_1)
    end
  end

  unless "".respond_to?(:safe_constantize)
    require "anyway/ext/string_constantize"
    using Anyway::Ext::StringConstantize
  end

  # TypeCaster is an object responsible for type-casting.
  # It uses a provided types registry and mapping, and also
  # accepts a fallback typecaster.
  class TypeCaster
    using Ext::DeepDup
    using Ext::Hash

    def initialize(mapping, registry: TypeRegistry.default, fallback: ::Anyway::AutoCast)
      @mapping = mapping.deep_dup
      @registry = registry
      @fallback = fallback
    end

    def coerce(key, val, config: mapping)
      caster_config = config[key.to_sym]

      return fallback.coerce(key, val) unless caster_config

      case; when ((__m__ = caster_config)) && false 
      when (((array, type) = nil) || ((Hash === __m__) && ((__m__.respond_to?(:deconstruct_keys) && (((__m_hash__src__ = __m__.deconstruct_keys(nil)) || true) && (Hash === __m_hash__src__ || Kernel.raise(TypeError, "#deconstruct_keys must return Hash"))) && (__m_hash__ = __m_hash__src__.dup)) && ((__m_hash__.key?(:array) && __m_hash__.key?(:type)) && (((array = __m_hash__.delete(:array)) || true) && (((type = __m_hash__.delete(:type)) || true) && __m_hash__.empty?))))))
        registry.deserialize(val, type, array: array)
      when (((subconfig,) = nil) || ((Hash === __m__) && (__m__.respond_to?(:deconstruct_keys) && (((__m_hash__ = __m__.deconstruct_keys([:config])) || true) && (Hash === __m_hash__ || Kernel.raise(TypeError, "#deconstruct_keys must return Hash"))) && (__m_hash__.key?(:config) && ((subconfig = __m_hash__[:config]) || true)))))



        subconfig = subconfig.safe_constantize if subconfig.is_a?(::String)
        raise ArgumentError, "Config is not found: #{subconfig}" unless subconfig

        subconfig.new(val)
      when (Hash === __m__)









        return val unless val.is_a?(Hash)

        caster_config.each do |k, v|
          ks = k.to_s
          next unless val.key?(ks)

          val[ks] = coerce(k, val[ks], config: caster_config)
        end

        val
      else
        registry.deserialize(val, caster_config)
      end
    end

    private

    attr_reader :mapping, :registry, :fallback
  end
end
