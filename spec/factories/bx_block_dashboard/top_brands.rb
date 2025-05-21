FactoryBot.define do
  factory :top_brand, class: "BxBlockDashboard::TopBrand" do
    sequence(:sequence_no) { |n| n % 6 + 1 }
    brand
  end
end
