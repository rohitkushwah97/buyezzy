module BxBlockShoppingCart
	class TelrPaymentsController < ApplicationController

		before_action :get_user
		before_action :find_order

		def create
			if @order.order_status.status == 'on_going'
				response = JSON.parse(post_gateway('create', @order, params))
				if response['order'].present?
					@order.update(transaction_id: response['order']['ref'])
				end
				render json: response, status: :ok
			else
				render json: {errors: "On going orders only accepted" }, status: :unprocessable_entity
			end
		end

		def show_or_check
			render json: post_gateway('check', @order, params), status: :ok
		end

		def payment_failed_notification
			begin
				BxBlockEmailNotifications::SendEmailNotificationService
				.with(account: @customer, subject: 'Sorry, your payment didn’t go through.', file: 'payment_failed_notification')
				.notification
				.deliver_now

				render json: { message: 'Payment failed notification sent successfully.' }, status: :ok
			rescue StandardError => e
				Rails.logger.error("Failed to send payment failed notification: #{e.message}")
				render json: { error: 'Failed to send payment failed notification.' }, status: :unprocessable_entity
			end
		end

		private

		def get_user
			@customer = AccountBlock::Account.find_by(id: @token.id, user_type: 'buyer' )
			render json: {errors: 'Customer is invalid'} and return unless @customer.present?
		end

		def find_order
			@order = @customer.orders.find_by(id: params[:order_id])
			render json: {errors: 'Order not found'} and return unless @order.present?
		end

		def post_gateway(action, order, params)
			url = URI("https://secure.telr.com/gateway/order.json")

			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true

			request = Net::HTTP::Post.new(url)
			request["accept"] = 'application/json'
			request["Content-Type"] = 'application/json'
			if action == 'create'
				request.body = {
					"method": "#{action}",
					"store": ENV['TELR_STORE_ID'],
					"authkey": ENV['TELR_AUTH_KEY'],
					"framed": 0,
					"order": {
						"cartid":"#{order&.order_number}",
						"test": ENV['TELR_LIVE_MODE'],
						"amount":"#{params[:final_price]}",
						"currency":"AED",
						"description":"Ordered products are (#{order&.catalogues&.map(&:product_title)&.join(", ")})"
					},
					"return":{
						"authorised":"#{ENV['FE_URL']}/checkout",
						"declined":"#{ENV['FE_URL']}/order-summary",
						"cancelled":"#{ENV['FE_URL']}/order-summary",
					},
					"customer": get_shipping_address(order)
				}.to_json
			else
				request.body =  {"method":"check", "store": ENV['TELR_STORE_ID'], "authkey": ENV['TELR_AUTH_KEY'], "order":{"ref": order&.transaction_id }}.to_json
			end

			response = http.request(request)
			response.read_body
		end

		def get_shipping_address(order)
			customer_details = {}
			address = order.shipping_address

			if address.present?
				customer_details = {
					"email": order&.customer&.email,
					"name": {
						"title": "",
						"forenames": address.first_name,
						"surname": address.last_name
					},
					"address": {
						"line1": address.address_1,
						"line2": address.address_2,
						"line3": "",
						"city": address.city,
						"state": address.state,
						"country": "AE",
						"areacode": address.zip_code
					}
				}
			end

			customer_details
		end

	end
end