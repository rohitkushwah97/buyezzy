FactoryBot.define do
  factory :bx_block_surveys_intern_characteristic_importance, class: 'BxBlockSurveys::InternCharacteristicImportance' do
    user_surveys_id { FactoryBot.create(:user_survey).id }
    intern_characteristic_id { FactoryBot.create(:intern_characteristic).id }
    value { 80 }
  end
end
