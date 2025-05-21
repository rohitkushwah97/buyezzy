FactoryBot.define do
  factory :catalogue_recommend, class: 'BxBlockRecommendation::CatalogueRecommend' do
    recommendation_setting {  Faker::Name.unique.name }
    value { false }

  end
end