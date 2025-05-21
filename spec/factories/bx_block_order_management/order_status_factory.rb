FactoryBot.define do
  factory :order_status, class: 'BxBlockOrderManagement::OrderStatus' do
    sequence(:name) do |n|
      Faker::Lorem.characters(number: 10).gsub(/\d/, '').upcase
    end
  end
end