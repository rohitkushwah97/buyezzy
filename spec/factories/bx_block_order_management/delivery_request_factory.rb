FactoryBot.define do
	factory :delivery_request, class: 'BxBlockOrderManagement::DeliveryRequest' do
		warehouse
		warehouse_name { 'warehouse 1' }
		trait :with_account do
			association :seller, factory: :account
		end
		trait :with_shopping_cart_order do
			association :order, factory: :shopping_cart_order
		end
		address_1 { '123 Main St' }
		address_2 { 'Apt 456' }
		status { 'pending' }

		after(:build) do |delivery_request|
			if delivery_request.order.present?
				delivery_request.order_number = delivery_request.order.order_number
			end
		end
	end
end