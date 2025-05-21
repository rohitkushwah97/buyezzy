FactoryBot.define do
  factory :micro_category, class: 'BxBlockCategories::MicroCategory' do
    name { Faker::Lorem.characters(number: 9, min_alpha: 5) }
    mini_category
  end
end
