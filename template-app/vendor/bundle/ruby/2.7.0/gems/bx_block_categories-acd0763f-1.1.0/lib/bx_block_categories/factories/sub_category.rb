# frozen_string_literal: true

FactoryBot.define do
  factory :sub_category, :class => 'BxBlockCategories::SubCategory' do
    name { Faker::Alphanumeric.unique.alphanumeric(number: 7) }
    categories { FactoryBot.create_list(:category, 1) }
    parent_id { nil }
  end
end
