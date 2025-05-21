FactoryBot.define do
  factory :variant_attribute ,class: 'BxBlockCatalogue::VariantAttribute' do
    attribute_name { Faker::Lorem.word }
    catalogue_variant
  end
end
