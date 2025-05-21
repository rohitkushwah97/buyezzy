FactoryBot.define do
	factory :shipped_order_detail, class: "BxBlockShoppingCart::ShippedOrderDetail" do
		shipping_details { "MyText" }
		courier_name { "courier name" }
		tracking_number {"tracking313234number"}
		trait :with_shopping_cart_order do
			association :order, factory: :shopping_cart_order
		end
	end
end