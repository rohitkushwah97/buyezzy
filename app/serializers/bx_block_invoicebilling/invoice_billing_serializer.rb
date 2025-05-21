module BxBlockInvoicebilling
	class InvoiceBillingSerializer < BuilderBase::BaseSerializer
		attributes :id, :invoice_number, :order_id, :order_item_id, :customer_id, :created_at, :updated_at

		attributes :invoice_pdf do |object|
			if object.invoice_pdf.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.invoice_pdf, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.invoice_pdf, only_path: true)
			end
		end
	end
end
