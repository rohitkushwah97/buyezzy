# frozen_string_literal: true

require "factory_bot"

require "account_block/factories"
require "bx_block_posts/factories"
require "bx_block_profile/factories"
require "bx_block_like/factories"
require "bx_block_categories/factories"
require "bx_block_comments/factories"

FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
