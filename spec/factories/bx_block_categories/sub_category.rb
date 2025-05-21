FactoryBot.define do
  factory :sub_category ,class: 'BxBlockCategories::SubCategory'do
    name { Faker::Lorem.characters(number: 11, min_alpha: 6)}
    category
  end
end
