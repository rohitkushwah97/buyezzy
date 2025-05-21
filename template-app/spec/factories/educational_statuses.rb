# factories/educational_statuses.rb
FactoryBot.define do
  factory :educational_status, class: 'BxBlockProfile::EducationalStatus' do
    name {Faker::Name.unique.name}
  end
end
