FactoryBot.define do
  factory :version, class: 'BxBlockSurveys::Version' do
    survey
    name {Faker::Name.unique.name}
  end
end