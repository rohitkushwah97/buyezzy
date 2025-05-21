FactoryBot.define do
  factory :business_user_generic_question, class: 'BxBlockSurveys::BusinessUserGenericQuestion' do
    question { "What is your favorite color?" }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
