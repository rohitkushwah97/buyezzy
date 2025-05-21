FactoryBot.define do
  factory :role, class: 'BxBlockCategories::Role' do
    name {Faker::Name.unique.name}
    industry
  end
end