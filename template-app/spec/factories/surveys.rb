FactoryBot.define do
  factory :survey, class: 'BxBlockSurveys::Survey' do
    name { Faker::Name.name }
    description { "description"}
    skip_minimum_questions_validation {true}
    role
  end
end