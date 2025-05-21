module BxBlockOrderManagement
  class AnchantoWmsController < ApplicationController
    skip_before_action :validate_json_web_token,
                       only: %i[event_consignment_status_update_in_wms event_b2c_shipment_status_update_in_wms
                                event_grn_status_update_in_wms]
    skip_before_action :get_user,
                       only: %i[event_grn_status_update_in_wms event_consignment_status_update_in_wms
                                event_b2c_shipment_status_update_in_wms]

    before_action :check_seller, only: %i[create_wms_product create_consignment_order b2c_order_index]
    before_action :find_catalogue, only: %i[create_wms_product create_consignment_order]
    before_action :find_order, only: %i[create_b2c_order]
    before_action :validate_params, only: %i[create_wms_product create_consignment_order]

    after_action :save_product_response, only: %i[create_wms_product], if: -> { successful_response? }
    after_action :save_consignment_response, only: %i[create_consignment_order], if: -> { successful_response? }

    def create_wms_product
      product_create_api = 'https://uatapi.anchanto.com/rest/v1/products'
      http_method = 'POST'

      request_body = product_details(@catalogue)

      response, response_code = send_request(product_create_api, request_body, http_method)
      handle_response(response, response_code)
    end

    def create_consignment_order
      create_consignment_api = 'https://uatapi.anchanto.com/rest/v1/consignments'
      @quantity = params[:quantity]
      http_method = 'POST'

      return render json: { message: 'Missing quantity' }, status: :unprocessable_entity if @quantity.blank?

      request_body = consignment_details(@catalogue, @quantity)
      response, response_code = send_request(create_consignment_api, request_body, http_method)

      handle_response(response, response_code)
    end

    def create_b2c_order
      create_b2c_order_api = 'https://uatapi.anchanto.com/rest/v1/b2c/orders'
      http_method = 'POST'

      order_items = @order.order_items.select { |item| item&.catalogue&.fulfilled_type == 'byezzy' }

      if order_items.any?
        request_body = b2c_order_details(@order, order_items)

        response, response_code = send_request(create_b2c_order_api, request_body, http_method)

        handle_response(response, response_code)
      else
        handle_response({ message: 'No byezzy products ordered' }, 404)
      end
    end

    def event_grn_status_update_in_wms
        process_wms_event(params)
    end

    def event_consignment_status_update_in_wms
      process_wms_event(params)
    end

    def event_b2c_shipment_status_update_in_wms
      process_wms_event(params)
    end

    def b2c_order_index
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      filter_created_by = params[:filter_created_by].presence
      http_method = 'GET'

      query_params = "page[number]=#{page_number}&page[size]=#{per_page}&filter[created_at]=#{filter_created_by}"

      b2c_order_index_api = "https://uatapi.anchanto.com/rest/v1/b2c/orders?#{query_params}"

      response, response_code = send_request(b2c_order_index_api, {}, http_method)

      if response_code.to_i == 200
        orders = filter_orders_by_seller(@json_response['data'], @seller)
        render json: {
          orders: orders,
          meta: @json_response['meta']
        }, status: :ok
      else
        render json: response, status: response_code
      end
    end

    def b2c_order_show
      order_number = params[:order_number]

      http_method = 'GET'

      b2c_order_show_api = "https://uatapi.anchanto.com/rest/v1/b2c/orders/#{order_number}/details"

      response, response_code = send_request(b2c_order_show_api, {}, http_method)

      if response_code.to_i == 200
        orders = filter_orders_by_seller([@json_response['data']], @seller)
        render json: {
          orders: orders,
          meta: @json_response['meta']
        }, status: :ok
      else
        render json: response, status: response_code
      end
    end

    private

    def check_seller
      @seller = @current_user if @current_user.user_type == 'seller'
      render json: { message: 'Invalid seller' }, status: :unprocessable_entity unless @seller
    end

    def find_catalogue
      @catalogue = BxBlockCatalogue::Catalogue.find_by(id: params[:catalogue_id])
      render json: { message: 'Catalogue not found' }, status: :unprocessable_entity unless @catalogue
    end

    def find_order
      @order = BxBlockShoppingCart::Order.find_by(id: params[:order_id])
      render json: { message: 'Order not found' }, status: :unprocessable_entity unless @order
    end

    def validate_params
      return if params[:authorization].present? && @seller

      render json: { message: 'Missing required params' }, status: :unprocessable_entity
    end

    def send_request(url, request_body, http_method)
      response, response_code = request_response_body(params[:authorization], url, request_body, http_method)
      @json_response = begin
        JSON.parse(response)
      rescue StandardError
        {}
      end
      [response, response_code]
    end

    def request_response_body(authorization, request_url, request_body, http_method)
      url = URI(request_url)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = if http_method == 'POST'
                  Net::HTTP::Post.new(url)
                else
                  Net::HTTP::Get.new(url)
                end
      request['Authorization'] =
        authorization || 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMDAyLCJ3X2NvZGUiOiJCRVpZIiwiZXhwIjoxNzYzMjE2ODQ0fQ.Gp1KqS4Jg5bzv8jbc8bs1fChxpwACK5oOrjRPQXiQN8'
      request['warehouse-code'] = ENV['WMS_WAREHOUSE_CODE']
      request['Content-Type'] = 'application/json'
      request.body = JSON.dump(request_body)

      response = https.request(request)
      [response.read_body, response.code]
    end

    def handle_response(response, response_code)
      if response_code.to_i == 200 && update_wms_warehouse
        create_warehouse_catalogue if @catalogue.present? && @warehouse.present?

        render json: @json_response.merge(
          catalogue: BxBlockCatalogue::CatalogueSerializer.new(@catalogue),
          order: BxBlockShoppingCart::OrderSerializer.new(@order)
        ), status: :ok
      else
        render json: response, status: response_code
      end
    end

    def update_wms_warehouse
      wms_attrs = {
        warehouse_type: 'anchanto',
        warehouse_name: ENV['WMS_WAREHOUSE_NAME'],
        warehouse_address_1: ENV['WMS_WAREHOUSE_ADDRESS'],
        warehouse_code: ENV['WMS_WAREHOUSE_CODE'],
        contact_number: ENV['WMS_WAREHOUSE_CONTACT'],
        contact_person: '',
        processing_days: 1
      }
      @warehouse = BxBlockCatalogue::Warehouse.find_or_initialize_by(warehouse_code: wms_attrs[:warehouse_code])
      @warehouse.assign_attributes(wms_attrs.merge(account_id: @seller&.id))
      @warehouse.save
    end

    def create_warehouse_catalogue
      variant_group = @catalogue.product_variant_group
      variant_group_id = variant_group&.id
      record = BxBlockCatalogue::WarehouseCatalogue.find_or_initialize_by(
        warehouse_id: @warehouse.id,
        catalogue_id: @catalogue.id,
        product_variant_group_id: variant_group_id
      )
      record.stocks = @catalogue.stocks
      record.save!
    end

    def b2c_order_details(order, order_items)
      final_price, total_discount = calculate_final_price(order_items)

      {
        "b2c_order": {
          "company_code": ENV['WMS_SUPPLIER_CODE'],
          "shipping_type": 'Purchase Order',
          "number": order.order_number,
          "currency_code": 'AED',
          "carrier": {
            "carrier_code": ENV['WMS_CARRIER_CODE'],
            "carrier_name": ENV['WMS_CARRIER_NAME']
          },
          "adjustment_attributes": {
            "total_paid": final_price,
            "discount": total_discount
          },
          "order_items_attributes": order_items_details(order_items),
          "billing_address_attributes": shipping_billing_address(order),
          "shipping_address_attributes": shipping_billing_address(order)
        }
      }
    end

    def calculate_final_price(order_items)
      total_price = calculate_total_price(order_items)
      total_discount_price = calculate_total_discount(order_items)

      [total_discount_price.to_f, (total_discount_price - total_price).to_f.round(2)]
    end

    def calculate_total_price(order_items)
      order_items.map do |item|
        (item&.catalogue&.product_content&.retail_price&.to_f || 0) * item.quantity
      end.sum.round(2)
    end

    def calculate_total_discount(order_items)
      order_items.sum { |item| item.assign_discount_to_order }
    end

    def order_items_details(order_items)
      order_items.map do |order_item|
        {
          "unit_price": order_item.price,
          "retail_price": order_item.catalogue&.product_content&.retail_price,
          "selling_price": (order_item.price * order_item.quantity),
          "quantity": order_item.quantity,
          "sku": order_item.catalogue&.is_variant ? order_item.catalogue&.product_variant_group&.product_bibc : order_item.catalogue&.bibc
        }
      end
    end

    def shipping_billing_address(order)
      shipping_address = order.shipping_address
      if shipping_address
        {
          "first_name": shipping_address.first_name,
          "last_name": shipping_address.last_name,
          "address1": shipping_address.address_1,
          "address2": shipping_address.address_2,
          "city": shipping_address.city,
          "zipcode": shipping_address.zip_code,
          "country_iso": 'AE',
          "state_abbreviation": 'AE',
          "phone": shipping_address.phone_number
        }
      else
        {}
      end
    end

    def consignment_details(product, quantity)
      {
        "consignment": {
          "supplier_code": ENV['WMS_SUPPLIER_CODE'],
          "ship_date": (Date.today + 2.days),
          "receiving_date": (Date.today + 4.days),
          "consignment_items_attributes": [
            {
              "unit_price": product.product_content&.retail_price,
              "quantity": quantity,
              "sku": product.is_variant ? product&.product_variant_group&.product_bibc : product.bibc
            }
          ]
        }
      }
    end

    def product_details(product)
      product_content = product&.product_content
      shipping_detail = product_content&.shipping_detail
      size_and_capacity = product_content&.size_and_capacity

      {
        "product": {
          "name": product.product_title,
          "sku": product.is_variant ? product&.product_variant_group&.product_bibc : product.bibc,
          "storage_type": 'standard',
          "low_threshold": 20,
          "buffer_stock": 10,
          "product_sales_informations_attributes": [{
            "currency_code": 'AED',
            "cost_price": product_content ? product_content.retail_price : 0.0
          }],
          "product_dimensions_attributes": [{
            "length_cm": shipping_detail&.shipping_length || 0,
            "width_cm": shipping_detail&.shipping_width || 0,
            "height_cm": shipping_detail&.shipping_height || 0,
            "weight_gm": shipping_detail&.shipping_weight || 0,
            "no_of_units": size_and_capacity&.number_of_pieces || 0
          }],
          "product_localizations_attributes": [{
            "country_iso": 'AE',
            "name": product.product_title
          }],
          "product_hs_attributes": [{
            "hs_code": size_and_capacity&.hs_code
          }]
        }
      }
    end

    def save_product_response
      product_dimensions_info_hash = @json_response.dig('data', 1, 'product_dimensions_info')
      product_dimensions_key = product_dimensions_info_hash.keys.first if product_dimensions_info_hash
      product_information_value = product_dimensions_info_hash.values.first if product_dimensions_info_hash

      WmsProductInfo.create(
        seller: @seller,
        catalogue: @catalogue,
        product_information_id: product_information_value,
        product_dimensions_info: product_dimensions_key
      )
    end

    def save_consignment_response
      order_number = @json_response.dig('order_number')

      WmsConsignmentOrder.create(
        seller: @seller,
        catalogue: @catalogue,
        order_number: order_number,
        quantity: @quantity,
        unit_price: @catalogue&.product_content&.retail_price
      )
    end

    def successful_response?
      @json_response.present? && @json_response['response'] == 'success'
    end

    def process_wms_event(event_params)
      if request.get?
        return render json: {message: "Anchanto WMS endpoint ready."}
      end
      unless event_params["event_parameters"].present?
        return render json: {message: "missing event parameters"}
      end

      return if event_params.blank?

      product_skus = event_params[:products].map { |product| product[:sku] }
      @products = BxBlockCatalogue::Catalogue.where(bibc: product_skus)

      @sellers = @products.map(&:seller).uniq

      if @sellers.present?
        @wms_response = event_params
        create_wms_event_update_and_notify_sellers
        render json: @wms_response, status: :ok
      else
        render json: { error: 'Seller not found' }, status: :unprocessable_entity
      end
    end

    def filter_orders_by_seller(orders_data, seller)
      orders_data.map do |order|
        filtered_items = filter_order_items_by_seller(order['attributes']['order_items'], seller)
        next if filtered_items.empty?

        order['attributes']['order_items'] = filtered_items
        order['attributes']['order_total'] = filtered_items.sum { |item| item['paid_price'].to_f }.round(2)
        order['attributes']
      end.compact
    end

    def filter_order_items_by_seller(order_items, seller)
      order_items.select do |item|
        catalogue = BxBlockCatalogue::Catalogue.find_by(bibc: item['sku'])
        catalogue&.seller == seller
      end
    end

    def create_wms_event_update_and_notify_sellers
      return unless @wms_response && @sellers

      @sellers.each do |seller|
        WmsEventUpdate.create(
          warehouse_code: @wms_response.dig(:event_parameters, :warehouse_code),
          consignment_type: @wms_response.dig(:event, :consignment_type),
          shipment_number: @wms_response.dig(:event, :shipment_number),
          po_number: @wms_response.dig(:event, :po_number),
          old_state: @wms_response.dig(:event, :old_state),
          new_state: @wms_response.dig(:event, :new_state),
          event_on: @wms_response.dig(:event, :event_on),
          time_zone: @wms_response.dig(:event, :time_zone),
          seller_email: seller.email,
          products: @wms_response[:products]
        )

        notify_seller_of_update(seller, @wms_response)
      end
    end

    def notify_seller_of_update(seller, wms_event)
      BxBlockEmailNotifications::SendEmailNotificationService
        .with(account: seller, subject: 'WMS Event Update', file: 'wms_event_notification', wms_event: wms_event)
        .notification.deliver_now
    end
  end
end

