FactoryBot.define do
  factory :school, class: 'BxBlockProfile::School' do
    name { Faker::Name.unique.name }
    educational_status
  end
end