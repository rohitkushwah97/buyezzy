FactoryBot.define do
  factory :special_feature, class: 'BxBlockCatalogue::SpecialFeature' do
    value { "MyString" }
    product_content
  end
end
