FactoryBot.define do
  factory :question_sub_type, :class => 'BxBlockHelpCentre::QuestionSubType' do
    sub_type { "Question Sub Type" }
    description { "Question Sub Type Description" }
    question_type
  end
end
