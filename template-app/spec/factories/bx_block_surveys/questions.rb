FactoryBot.define do
  factory :question, class: 'BxBlockSurveys::Question' do
    business_question { "test business question" }
    intern_question { "test intern question" }
    default_weight { 12 }
    association :version
    intern_characteristic
    association :survey

    after(:build) do |question|
      5.times do |i|
        question.options << build(:option, name: "Option #{i + 1}", question: question)
      end
    end

  end
end