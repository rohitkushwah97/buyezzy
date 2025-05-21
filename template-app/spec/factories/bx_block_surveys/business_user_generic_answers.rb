FactoryBot.define do
  factory :business_user_generic_answer, class: 'BxBlockSurveys::BusinessUserGenericAnswer' do
    answer { "John Doe" }
    association :business_user, factory: :business_user
    association :internship, factory: :internship
    association :business_user_generic_question, factory: :business_user_generic_question

    created_at { Time.current }
    updated_at { Time.current }
  end
end
