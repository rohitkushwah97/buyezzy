# frozen_string_literal: true

require 'factory_bot'

FactoryBot.find_definitions

require 'account_block/factories'
require 'bx_block_categories/factories'
require 'bx_block_location/factories'
require 'bx_block_favourites/factories'
require 'bx_block_like/factories'
require 'bx_block_request_management/factories'
require 'bx_block_profile_bio/factories'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
