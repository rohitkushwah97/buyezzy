module BxBlockShoppingCart
	module OrderConcern
		extend ActiveSupport::Concern

		def get_delivery_address(order)
			delivery_address = order.shipping_address

			if order.shipping_first_name.blank?
				return AccountBlock::UserDeliveryAddressSerializer.new(delivery_address)
			end

			{
				data: {
					id: delivery_address&.id,
					type: "user_delivery_address",
					attributes: {
						address_status: "ordered",
						first_name: order.shipping_first_name,
						last_name: order.shipping_last_name,
						address_1: order.shipping_address_1,
						address_2: order.shipping_address_2,
						phone_number: order.shipping_phone_number,
						state: order.shipping_state,
						city: order.shipping_city,
						zip_code: order.shipping_zip_code,
						account_id: delivery_address&.account_id,
						is_default: delivery_address&.is_default
					}
				}
			}
		end

	end
end