# frozen_string_literal: true

module BxBuilderChain
  module DependencyHelper
    class VersionError < ScriptError; end

    # This method requires and loads the given gem, and then checks to see if the version of the gem meets the requirements listed in `langchain.gemspec`
    # This solution was built to avoid auto-loading every single gem in the Gemfile when the developer will mostly likely be only using a few of them.
    #
    # @param gem_name [String] The name of the gem to load
    # @return [Boolean] Whether or not the gem was loaded successfully
    # @raise [LoadError] If the gem is not installed
    # @raise [VersionError] If the gem is installed, but the version does not meet the requirements
    #
    def depends_on(gem_name)
      Gem::Specification.find_by_name(gem_name)
      true
    rescue LoadError
      raise LoadError, "!Could not load #{gem_name}. Please ensure that the #{gem_name} gem is installed."
    end
  end
end
