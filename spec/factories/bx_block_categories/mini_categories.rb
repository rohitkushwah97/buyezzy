FactoryBot.define do
  factory :mini_category,class: 'BxBlockCategories::MiniCategory' do
    name { Faker::Lorem.characters(number: 11, min_alpha: 5) }
    sub_category
  end
end
