# Protected Area Start
# frozen_string_literal: true
# This file is copied to spec/ when you run 'rails generate rspec:install'
require_relative 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("./dummy/config/environment", __dir__) unless ENV['RSPEC_APP_SOURCE'] == 'client_app'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir["#{__dir__}" + "/support/**/**/*.rb"].each { |f| require f }

# Ensure app/admin is included in autoload paths
Dir[File.expand_path("../app/admin/**/*.rb", __dir__)].each { |f| require f }

# Protected Area End

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end