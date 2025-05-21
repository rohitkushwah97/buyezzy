FactoryBot.define do
  factory :warehouse_catalogue, class: 'BxBlockCatalogue::WarehouseCatalogue' do
    association :warehouse, factory: :warehouse
    association :catalogue, factory: :catalogue
    association :product_variant_group, factory: :product_variant_group
    stocks { Faker::Number.number(digits: 3) }
  end
end