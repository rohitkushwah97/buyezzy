module BxBlockOrderManagement
	class DeliveryRequest < ApplicationRecord
		self.table_name = :delivery_requests

		#enum status: [:pending, :accepted, :rejected]
		# validates :status, inclusion: { in: statuses.keys, message: "%{value} is not a valid status" }
		validates :order_number, presence: true
		belongs_to :warehouse, class_name: 'BxBlockCatalogue::Warehouse'
		belongs_to :seller, class_name: "AccountBlock::Account"
		belongs_to :order, class_name: 'BxBlockShoppingCart::Order', optional: true

		validate :validate_address
		validate :validate_order_number
		before_save :assign_default_status, if: Proc.new {|a| a.new_record?}

		private

		def validate_address
			unless self.address_1.present? || self.geo_location.present?
				errors.add(:address_1, "is missing or select geo location")
			end
		end

		def validate_order_number
			order_statuses = BxBlockOrderManagement::OrderStatus.where(status: ['processing'])
			errors.add(:order_number, "is invalid") unless BxBlockShoppingCart::Order.includes(:order_status).where(order_number: order_number, order_statuses: { id: order_statuses.map(&:id) }).exists?
		end

		def assign_default_status
			self.status = 'pending'
		end

	end
end