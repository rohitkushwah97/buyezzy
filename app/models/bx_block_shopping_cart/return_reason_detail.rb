module BxBlockShoppingCart
	class ReturnReasonDetail < ApplicationRecord
		self.table_name = :return_reason_details

		enum reason_type: %i[return_reason pickup_and_delivery reason_for_qc_fail]
		belongs_to :order_item, class_name: 'BxBlockShoppingCart::OrderItem', foreign_key: :shopping_cart_order_item_id
		validates :title, :details, :reason_type, presence: true
	end
end