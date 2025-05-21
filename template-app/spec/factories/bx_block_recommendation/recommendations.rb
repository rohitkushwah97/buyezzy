FactoryBot.define do
  factory :bx_block_recommendation_recommendation, class: 'BxBlockRecommendation::Recommendation' do
    intern_user { nil }
    internship { nil }
    match_type { "MyString" }
  end
end
