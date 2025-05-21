module BxBlockInvoicebilling
	class InvoiceBilling < ApplicationRecord
		self.table_name = :invoice_billings

		belongs_to :customer, class_name: 'AccountBlock::Account'
		belongs_to :order, class_name: 'BxBlockShoppingCart::Order'
		belongs_to :order_item, class_name: 'BxBlockShoppingCart::OrderItem'

		has_one_attached :invoice_pdf, dependent: :destroy

		before_create :generate_invoice_number

		private

		def generate_invoice_number
			self.invoice_number ||= loop do
				random_number = SecureRandom.alphanumeric(7)
				break random_number unless self.class.exists?(invoice_number: random_number)
			end
		end

	end
end