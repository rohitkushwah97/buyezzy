FactoryBot.define do
  factory :question_answer, :class => 'BxBlockHelpCentre::QuestionAnswer' do
    question { "Test Question" }
    answer { "Test Answer" }
    question_sub_type
  end
end
