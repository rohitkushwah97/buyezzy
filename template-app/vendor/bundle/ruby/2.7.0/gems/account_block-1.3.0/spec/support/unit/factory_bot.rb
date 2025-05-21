# frozen_string_literal: true

require "factory_bot"

require "account_block/factories"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
