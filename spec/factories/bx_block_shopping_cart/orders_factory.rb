FactoryBot.define do
	factory :shopping_cart_order, class: "BxBlockShoppingCart::Order" do
		status {0}
		total_fees {123}
		total_tax {0.0}
		discount {0.0}
		final_price {123}

		trait :with_account do
			association :customer, factory: :account
		end
		
		trait :with_user_delivery_address do
			association :shipping_address, factory: :user_delivery_address
		end
	end
end
