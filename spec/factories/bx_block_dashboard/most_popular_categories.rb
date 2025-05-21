FactoryBot.define do
  factory :most_popular_category, class: "BxBlockDashboard::MostPopularCategory" do
    sequence(:sequence_no) { |n| n % 6 + 1 }
    category
  end
end
