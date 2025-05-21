module BxBlockInvoicebilling
	class InvoiceBillingsController < ApplicationController

		before_action :find_order
		before_action :find_user

		def invoice_pdf
			@invoice = InvoiceBilling.create(order: @order, order_item: @order_item, customer: @user)
			pdf = Prawn::Document.new
			generate_invoice_pdf(pdf, @order, @order_item, @invoice, @transaction_details)
			pdf.render_file("#{Rails.root}/tmp/invoice-#{Time.now.strftime("%d-%m-%Y-%H-%M")}.pdf")

			@invoice.invoice_pdf.attach(io: File.open("#{Rails.root}/tmp/invoice-#{Time.now.strftime("%d-%m-%Y-%H-%M")}.pdf"), filename: "invoice-#{Time.now.strftime("%d-%m-%Y-%H-%M")}.pdf")

			render json: BxBlockInvoicebilling::InvoiceBillingSerializer.new(@invoice).serializable_hash
		end

		private

		def find_order
			@order = BxBlockShoppingCart::Order.all.includes(:order_status).where.not('order_statuses.status': ['on_going','ordered','scheduled']).find_by(id: params[:order_id])
			render json: { error: "Order not found or not delivered" }, status: :not_found and return unless @order
			@order_item = @order.order_items.find params[:order_item_id]
			@transaction_details = get_transaction_details(@order) ? JSON.parse(get_transaction_details(@order)) : get_transaction_details(@order)
		end

		def get_transaction_details(order)
			if order.transaction_id
				url = URI("https://secure.telr.com/gateway/order.json")
				http = Net::HTTP.new(url.host, url.port)
				http.use_ssl = true
				request = Net::HTTP::Post.new(url)
				request["accept"] = 'application/json'
				request["Content-Type"] = 'application/json'

				request.body =  {"method":"check", "store": ENV['TELR_STORE_ID'], "authkey": ENV['TELR_AUTH_KEY'], "order":{"ref": order.transaction_id }}.to_json

				response = http.request(request)
				response.read_body
			end
		end

		def find_user
			@user = AccountBlock::Account.find_by(id: @token.id)
			render json: { error: "User Invalid" }, status: :not_found and return unless @user && @order.customer == @user
		end

		def generate_invoice_pdf(pdf, order, order_item, invoice, transaction_details)

			pdf.font_families.update("Roboto" => {
				normal: "#{Rails.root}/lib/fonts/open_sans/static/OpenSans-Regular.ttf",
				bold: "#{Rails.root}/lib/fonts/open_sans/static/OpenSans-Bold.ttf"
			})

			pdf.font "Roboto"

			pdf.text "Invoice", size: 30, style: :bold, align: :center

			pdf.move_down 20
			pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width / 2) do
				pdf.text "Sold By:", size: 15, style: :bold
				pdf.text "Name: #{order_item.seller.full_name}"
				pdf.text "Company: #{order_item.seller.company_or_store_name}"
				pdf.text "Email: #{order_item.seller.email}"
				pdf.text "Phone no: #{order_item.seller.full_phone_number}"
			end

			pdf.move_down 20
			y_position = pdf.cursor
			pdf.bounding_box([0, y_position], width: pdf.bounds.width / 2) do
				pdf.text "Billing Address:", size: 15, style: :bold
				pdf.text "#{order.shipping_first_name} #{order.shipping_last_name}"
				pdf.text "#{order.shipping_address_1}"
				pdf.text "#{order.shipping_address_2}" if order.shipping_address_2.present?
				pdf.text "#{order.shipping_city}, #{order.shipping_state}, #{order.shipping_zip_code}"
			end

			pdf.bounding_box([300, y_position], width: pdf.bounds.width / 2) do
				pdf.text "Shipping Address:", size: 15, style: :bold
				pdf.text "#{order.shipping_first_name} #{order.shipping_last_name}"
				pdf.text "#{order.shipping_address_1}"
				pdf.text "#{order.shipping_address_2}" if order.shipping_address_2.present?
				pdf.text "#{order.shipping_city}, #{order.shipping_state}, #{order.shipping_zip_code}"
			end

			pdf.move_down 20
			pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width / 2) do
				pdf.text "Order Information", size: 15, style: :bold
				pdf.text "Order ID: #{order.order_number}"
				pdf.text "Order Date: #{order.order_placed_at&.strftime('%Y-%m-%d')}"
			end
			pdf.move_up 50
			pdf.bounding_box([400, pdf.cursor], width: pdf.bounds.width / 2) do
				pdf.text "Invoice Details", size: 15, style: :bold
				pdf.text "Invoice ID: #{invoice.invoice_number}"
				pdf.text "Invoice Date: #{order.delivered_at&.strftime('%Y-%m-%d')}"
			end

			pdf.move_down 20
			pdf.text "Order Item Information", size: 15, style: :bold
			pdf.move_down 10
			pdf.table([["S.No", "Item", "Quantity", "Price", "Total"]] +
				[[1, order_item.catalogue.product_title, order_item.quantity, "AED #{order_item.price}", "AED #{order_item.quantity * order_item.price}"]],
				header: true,
				width: pdf.bounds.width) do
				row(0).font_style = :bold
				row(0).background_color = "DDDDDD"
				self.cell_style = { borders: [] }
			end

			total_price = order_item.quantity * order_item.price

			pdf.move_down 20
			pdf.text "Amount In Words: #{total_price.to_words.humanize.capitalize} dirhams", size: 10, style: :bold

			if transaction_details
				pdf.move_down 20
				pdf.table([["Transaction ID", "Date & Time", "Invoice value", "Mode Of paymemt"]] +
					[[transaction_details.dig('order','transaction','ref'),transaction_details.dig("order","transaction","date"),"AED #{total_price}",transaction_details.dig("order","card","type")]],
					header: true,
					width: pdf.bounds.width) do
					row(0).font_style = :bold
					row(0).background_color = "DDDDDD"
					self.cell_style = { borders: [] }
				end
			end
		end

	end
end
