FactoryBot.define do
  factory :group_attribute, class: 'BxBlockCatalogue::GroupAttribute' do
    product_variant_group
    attribute_name { "MyString" }
    option { "MyString" }
  end
end
