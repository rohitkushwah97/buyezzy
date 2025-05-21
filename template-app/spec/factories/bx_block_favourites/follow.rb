require 'factory_bot'
FactoryBot.define do
  factory :follow, class: 'BxBlockFavourites::Follow' do
    account_id { 1 }
    follow_id { 2 }
  end
end