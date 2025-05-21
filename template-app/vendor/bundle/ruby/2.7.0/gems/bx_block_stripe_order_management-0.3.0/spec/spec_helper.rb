# frozen_string_literal: true

# 3rd party gems
require "faker"
require "fast_jsonapi" # suppop "rails_helper"rt for BuilderBase::BaseSerializer without Rails
require "debug"

# custom gems
require "builder_base/../../app/serializers/builder_base/base_serializer"

# unit-testable classes/modules
[
  "./app/serializers/**/*.rb",
  "./app/services/**/*.rb"
].each do |glob|
  Dir[glob].sort.each { |path| require path }
end

# spec support files
Dir["./spec/support/**/*.rb"].sort.each { |path| require path }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.disable_monkey_patching!

  config.backtrace_exclusion_patterns = [
    %r{/gems/}
  ]

  config.order = :random

  Kernel.srand config.seed
end
