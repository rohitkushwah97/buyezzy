# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: "BxBlockCategories::Category" do
    name { generate :category_name }
  end
end
