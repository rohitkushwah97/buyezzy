FactoryBot.define do
  factory :intern_user_generic_answer, class: 'BxBlockSurveys::InternUserGenericAnswer' do
    
    answer { "My name is John Doe." }
    association :internship, factory: :bx_block_navmenu_internship
    association :account, factory: :account
    association :intern_user_generic_question, factory: :intern_user_generic_question
  end
end
