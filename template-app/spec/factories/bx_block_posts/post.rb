require 'factory_bot'
FactoryBot.define do
  factory :post, class: 'BxBlockPosts::Post' do
    name { "post" }
    body { "New Post" }
    category_id { 1 }
  end
end