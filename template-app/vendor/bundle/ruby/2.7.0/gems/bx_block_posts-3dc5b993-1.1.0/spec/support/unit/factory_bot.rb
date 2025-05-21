# frozen_string_literal: true

require 'factory_bot'

FactoryBot.find_definitions

require 'account_block/factories'
require 'bx_block_posts/factories'
require "bx_block_categories/factories"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
