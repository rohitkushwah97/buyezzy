# frozen_string_literal: true

require 'factory_bot'
require 'bx_block_fedex_integration/factories'

require 'account_block/factories'

FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
