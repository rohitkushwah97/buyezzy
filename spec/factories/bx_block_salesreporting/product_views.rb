FactoryBot.define do
  factory :product_view, class: "BxBlockSalesreporting::ProductView" do
    catalogue
    user { nil }
    viewed_at { Time.now }
  end
end
