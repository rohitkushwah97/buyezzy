module BuilderBase
  class RailsVersion
    class << self
      def for_new_apps(studio_type:)
        case studio_type
        when :studio_pro then minimum
        when :studio_store then maximum
        else raise ArgumentError.new("Unknown studio_type: #{studio_type}")
        end
      end

      def gemspec_constraint
        [">= #{minimum}", "<= #{maximum}"]
      end

      def minimum
        "6.0.3.6"
      end

      def maximum
        "6.1.7.6"
      end

      def supported?(version)
        Gem::Version.new(version).between?(
          Gem::Version.new(minimum),
          Gem::Version.new(maximum)
        )
      end
    end
  end
end
