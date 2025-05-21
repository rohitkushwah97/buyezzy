FactoryBot.define do
  factory :academic_level, class: 'BxBlockProfile::AcademicLevel' do
    name { Faker::Name.unique.name }
  end
end