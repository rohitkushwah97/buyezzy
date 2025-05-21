module BxBlockShoppingCart
	class ShippedOrderDetail < ApplicationRecord
		self.table_name = :shipped_order_details
		
		belongs_to :order, class_name: 'BxBlockShoppingCart::Order', foreign_key: :order_id, optional: true
		belongs_to :order_item, class_name: 'BxBlockShoppingCart::OrderItem', foreign_key: :order_item_id, optional: true
		validates :courier_name, :tracking_number, presence: true
	end
end