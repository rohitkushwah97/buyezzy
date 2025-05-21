# Protected Area Start
# frozen_string_literal: true

# 3rd party gems
require 'fast_jsonapi' # support for BuilderBase::BaseSerializer without Rails
require 'builder_json_web_token/support/shared_contexts'
require 'countries/global'
require 'active_model'

# custom gems
require 'builder_base/../../app/serializers/builder_base/base_serializer'

unless ENV['RSPEC_APP_SOURCE'] == 'client_app'
  require "simplecov"

  SimpleCov.profiles.define 'account_block' do
    load_profile 'rails'
    add_filter %r{app/jobs/[^\/]+/application_job.rb}
    add_filter %r{app/mailers/[^\/]+/application_mailer.rb}
    add_filter %r{app/models/[^\/]+/application_record.rb}
    add_filter %r{lib/generators/[^\/]+/block/install_generator.rb}
    add_filter 'vendor'

    add_group "Controllers", "app/controllers"
    add_group "Models", "app/models"
    add_group "Serializers", "app/serializers"
    add_group "Adapters", "app/adapters"
    add_group "Services", "app/services"
  end
  SimpleCov.start 'account_block'
end
# Protected Area End

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
    /\/gems\//,
  ]

  config.order = :random

  Kernel.srand config.seed
end
