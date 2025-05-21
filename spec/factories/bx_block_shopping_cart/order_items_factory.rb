FactoryBot.define do
	factory :shopping_cart_order_item, class: "BxBlockShoppingCart::OrderItem" do
		price {123}
		quantity {2}
		taxable {false}
		taxable_value {0.0}
		catalogue
		trait :with_shopping_cart_order do
			association :order, factory: :shopping_cart_order
		end
	end
end
