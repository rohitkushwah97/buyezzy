FactoryBot.define do
  factory :industry, class: 'BxBlockCategories::Industry' do
    name {Faker::Name.unique.name}
  end
end