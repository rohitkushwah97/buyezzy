FactoryBot.define do
  factory :user_survey, class: 'BxBlockSurveys::UserSurvey' do
    account_id { FactoryBot.create(:business_user).id }
    association :career_interest
    internship_id  { FactoryBot.create(:bx_block_navmenu_internship).id }
    quiz_status { "pending" }
  end
end