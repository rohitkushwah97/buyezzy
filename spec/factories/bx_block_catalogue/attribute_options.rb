FactoryBot.define do
  factory :attribute_option ,class: 'BxBlockCatalogue::AttributeOption' do
    option { Faker::Lorem.word }
    variant_attribute
  end
end
