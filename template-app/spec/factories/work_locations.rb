# factories/work_locations.rb
FactoryBot.define do
  factory :work_location, class: 'BxBlockSettings::WorkLocation' do
    name {Faker::Name.unique.name}
  end
end