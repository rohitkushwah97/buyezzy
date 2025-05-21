FactoryBot.define do
  factory :feature_bullet, class: 'BxBlockCatalogue::FeatureBullet'  do
    value { "MyString" }
    product_content
  end
end
