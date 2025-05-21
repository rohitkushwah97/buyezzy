FactoryBot.define do
  factory :question_type, :class => 'BxBlockHelpCentre::QuestionType' do
    que_type { "Fan Questions" }
    description { "Learn how to be a true fan" }
  end
end
