FactoryBot.define do
  factory :intern_user_generic_question, class: 'BxBlockSurveys::InternUserGenericQuestion' do
    question { "What is your name?" }
    association :business_user, factory: :business_user
    association :internship, factory: :bx_block_navmenu_internship
  end
end
