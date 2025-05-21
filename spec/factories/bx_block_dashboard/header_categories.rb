FactoryBot.define do
  factory :header_category, class: "BxBlockDashboard::HeaderCategory" do
    sequence(:sequence_no) { |n| n % 6 + 1 }
    category
  end
end