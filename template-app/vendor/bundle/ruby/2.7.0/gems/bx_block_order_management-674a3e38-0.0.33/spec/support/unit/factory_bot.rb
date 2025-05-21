# frozen_string_literal: true

require "factory_bot"

require "account_block/factories"
require "bx_block_order_management/factories"
require "bx_block_catalogue/factories"
require "bx_block_categories/factories"
require "bx_block_coupon_cg/factories"

FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
