module BxBlockShoppingCart
	class ReturnExchangeRequest < ApplicationRecord
		self.table_name = :return_exchange_requests
		
		belongs_to :customer, class_name: 'AccountBlock::Account'
		belongs_to :order, class_name: 'BxBlockShoppingCart::Order'
		has_and_belongs_to_many :order_items, class_name: 'BxBlockShoppingCart::OrderItem', join_table: :order_items_return_exchange_requests

		validates :order_number, :request_type, :request_reason, presence: true
	end
end