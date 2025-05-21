FactoryBot.define do
  factory :university, class: 'BxBlockProfile::University' do
    name { Faker::Name.unique.name }
    educational_status
  end
end