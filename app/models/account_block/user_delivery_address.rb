module AccountBlock
	class UserDeliveryAddress < ApplicationRecord
		self.table_name = :user_delivery_addresses
		belongs_to :account, class_name: "AccountBlock::Account"
		has_many :orders, class_name: 'BxBlockShoppingCart::Order', foreign_key: :address_id

		validates :first_name, :last_name, :address_1, :address_2, :phone_number, :state, :city, presence: true
		
		# validate :valid_phone_number

		before_save :check_and_update_default
		after_save :modify_order_shipping_address

		before_destroy :nullify_order_address

		# def valid_phone_number
		# 	unless Phonelib.valid?(phone_number)
		# 		errors.add(:phone_number,"Invalid or Unrecognized")
		# 	end
		# end

		private

		def nullify_order_address
			orders.update_all(address_id: nil)
		end 

		def check_and_update_default
			return unless is_default?

			account.user_delivery_addresses.where.not(id: id).update_all(is_default: false)
		end

		def modify_order_shipping_address
			if is_default? && account.orders.present?
				order = account.orders.includes(:order_status).find_by(order_statuses: { status: ["scheduled"] })
				order.update(address_id: id) if order
			end
		end

	end
end