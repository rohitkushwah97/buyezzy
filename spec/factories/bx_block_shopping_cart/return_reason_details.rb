FactoryBot.define do
  factory :return_reason_detail, class: "BxBlockShoppingCart::ReturnReasonDetail" do
    title { "MyString" }
    details { "MyText" }
    reason_type { "return_reason" }
  #   trait :with_shopping_cart_order_item do
		# 	association :order_item, factory: :shopping_cart_order_item
		# end
  end
end
