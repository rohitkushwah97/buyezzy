module BxBlockShoppingCart
  class OrdersController < ApplicationController
    include BxBlockShoppingCart::OrderConcern

    before_action :get_user, only: %i[index show create index apply_coupon_to_order]
    before_action :find_order, only: %i[show apply_coupon_to_order]

    before_action :find_seller, only: %i[seller_orders show_seller_order]

    def index
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      total_count = 0
      orders = @customer.orders.includes(:order_status)
      filtered_orders = filter_orders(params, orders).order(order_placed_at: :desc)

      if params[:order_item_status].present?
        total_count = BxBlockShoppingCart::OrderItem.includes(:order_status)
                                                    .where(order: filtered_orders)
                                                    .where(order_statuses: { status: params[:order_item_status].map(&:downcase).map(&:parameterize).map(&:underscore) })
                                                    .count
      else
        total_count = filtered_orders.includes(:order_items).count('shopping_cart_order_items.id')
      end

      filtered_orders = filtered_orders.page(page_number).per(per_page) if filtered_orders.present?

      orders_json = custom_order_response(filtered_orders, params[:order_item_status] || [])

      render json: { orders: orders_json, total_count: total_count }
    end

    def seller_orders
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1

      params[:fulfilled_by]

      orders = Order.all.includes(:order_status)
                    .joins(order_items: { catalogue: %i[seller product_content] })
                    .where('accounts.id': @seller.id).where.not(order_statuses: { name: 'Return' })
      seller_filtered_orders = filter_orders(params, orders)
      total_count = seller_filtered_orders.count
      order_items = seller_filtered_orders.flat_map do |order|
        # order.order_items.select { |item| @seller.catalogues.map(&:id).include?(item.catalogue_id) }
        filter_seller_order_items(order, params[:fulfilled_by]).map do |item|
          filter_by = Array(params[:filter_by])
          if filter_by.present? && !filter_by.include?(item&.order_status&.status.to_s)
            next
          end
          {
            order: order,
            order_item: item,
            catalogue: item.catalogue
          }
        end
      end
      case params[:sort_by]
      when 'date_latest'
        sorted_orders = seller_filtered_orders.order(order_placed_at: :desc)
      when 'date_oldest'
        sorted_orders = seller_filtered_orders.order(order_placed_at: :asc)
      when 'product_name_AZ'
        sorted_orders = seller_filtered_orders.order('product_contents.product_title ASC')
        order_items = order_items.sort_by do |item|
          item[:order_item].catalogue&.product_content&.product_title
        end
      when 'product_name_ZA'
        sorted_orders = seller_filtered_orders.order('product_contents.product_title DESC')
        order_items = order_items.sort_by { |item| item[:order_item].catalogue&.product_content&.product_title }.reverse
      else
        sorted_orders = seller_filtered_orders.order(order_placed_at: :desc)
        # order_items = order_items.sort_by { |obj| obj[:order].order_placed_at || Time.at(0).reverse }
      end

      if params[:search_query].present?
        search_query = params[:search_query].downcase
        sorted_orders = sorted_orders.where('lower(catalogues.sku) LIKE :query OR lower(order_number) LIKE :query',
                                            query: "%#{search_query}%")
        total_count = sorted_orders.count
      end

      paginated_orders = sorted_orders.page(page_number).per(per_page)
      render json: { message: 'No order present ', total_count: 0 } and return unless paginated_orders.present?

      render json: render_show_seller_order(paginated_orders, order_items, total_count)
    end

    def show_seller_order
      order = Order.includes(:order_status)
                   .joins(order_items: { catalogue: :seller })
                   .find_by('accounts.id': @seller.id, id: params[:id])

      render json: { message: 'Order not found' } and return unless order.present?


      order_items = order.order_items.select { |item| @seller.catalogues.map(&:id).include?(item.catalogue_id) }
      all_order_items = order_items.map do |item|
        { order: order, order_item: item, catalogue: item.catalogue }
      end

      render json: render_show_seller_order([order], all_order_items, nil)
    end

    def apply_coupon_to_order
      coupon_code = BxBlockCouponCg::CouponCode.find_by(code: params[:coupon_code])
      if coupon_code && @order.coupon_code.blank?
        update_discount_to_order(@order, coupon_code)
        render json: BxBlockShoppingCart::OrderSerializer.new(@order).serializable_hash.merge({ message: 'coupon_code applied' })
      else
        render json: { errors: 'Invalid coupon code or coupon code not active' }, status: :unprocessable_entity
      end
    end

    def show
      if %w[on_going scheduled].include?(@order.order_status&.status)
        @order.order_items.each do |order_item|
          order_item.assign_price_to_order_item
          order_item.save
        end
        @order.reload
      end
      render json: BxBlockShoppingCart::OrderSerializer.new(@order)
    end

    def update
      order_status_name = order_params.delete(:status)
      order_status = BxBlockOrderManagement::OrderStatus.find_by(status: order_status_name&.downcase)
      order = Order.find_by(id: params[:id])
      order_items = order.order_items.where(id: params[:orders][:order_item_id])
      user = AccountBlock::Account.find_by(id: @token.id)
      render json: { errors: 'User invalid' } and return unless user.present?

      order_failed_action = 'Order Status update failed'
      order_failed_message = "Order(id: #{order.order_number}) status failed to update, tried update status to #{order_status_name} by #{user.full_name}"

      if order.present? && order_status.present?
        Rails.logger.info "#{order_params}"
        puts order_params
        order.update(order_params.merge(order_status_id: order_status.id))
        if order_items.update(order_status_id: order_status.id, accepted: params[:orders][:accepted])
          order_activity_log(user, 'Order Status updated',
                             "Order(id: #{order.order_number}) status updated to #{order_status_name == 'ordered' ? 'ordered/placed' : order_status_name} by #{user.full_name}")
          render json: BxBlockShoppingCart::OrderSerializer.new(order).serializable_hash
        else
          order_activity_log(user, order_failed_action, order_failed_message)
          render json: {
            errors: format_activerecord_errors(order.errors)
          }, status: :unprocessable_entity
        end
      else
        order_activity_log(user, order_failed_action, order_failed_message)
        render json: { errors: 'Invalid order or order status' }, status: :unprocessable_entity
      end
    end

    # // these api only for BE , for deleting purpose in testing datas
    def destroy
      order = Order.find_by(id: params[:id])
      return unless order

      order.destroy
      render json: { message: 'order destroyed' }, status: :ok
    end

    def destroy_all_orders
      orders = BxBlockShoppingCart::Order.all

      if orders.empty?
        render json: { message: 'No orders present' }, status: :ok
      else
        orders.destroy_all
        order_items = BxBlockShoppingCart::OrderItem.all
        # // this deletion added for order items because some order deleted previously but not order items
        order_items.destroy_all if order_items.present?
        render json: { message: 'Destroyed all orders' }, status: :ok
      end
    end

    private

    def order_params
      params.require(:orders).permit(
        :status, :address_id, :order_status_id, :accepted
      )
    end

    def get_user
      @customer = AccountBlock::Account.find_by(id: @token.id, user_type: 'buyer')
      render json: { errors: 'Customer is invalid' } and return unless @customer.present?
    end

    def find_seller
      @seller = AccountBlock::Account.find_by(id: @token.id, user_type: 'seller')
      render json: { errors: 'Seller is invalid' } and return unless @seller
    end

    def find_order
      @order = @customer.orders.find(params[:id])
    end

    def calculate_discount(order, coupon_code)
      discount_amount = (order.total_fees * (coupon_code.discount.to_f / 100)).round(2)

      [discount_amount, order.total_fees].min
    end

    def update_discount_to_order(order, coupon_code)
      order.coupon_code = coupon_code
      discount = calculate_discount(order, coupon_code) || 0.0
      total_discount = order.discount + discount
      final_price = order.final_price - discount
      order.update(discount: total_discount, final_price: final_price)
    end

    def filter_orders(params, orders)
      if params[:filter_by].present? && params[:filter_by] == 'history'
        orders.completed_cancelled
      elsif params[:filter_by].present? && params[:filter_by].is_a?(Array)
        orders.where('order_statuses.status': params[:filter_by].map(&:downcase).map(&:parameterize).map(&:underscore))
      elsif params[:filter_by].present?
        orders.where('order_statuses.status': params[:filter_by]&.downcase&.parameterize&.underscore)
      else
        orders
      end
    end

    def render_show_seller_order(orders, all_order_items, total_count)
      result = all_order_items.compact.map do |entry|
        order = entry[:order]
        order_item = entry[:order_item]
        catalogue = entry[:catalogue]

        {
          order_id: order.id,
          order_number: order.order_number,
          status: order.status,
          total_fees: calculate_total_fees(Array(order_item)),
          total_items: count_total_items(Array(order_item)),
          discount: calculate_total_discount(Array(order_item)),
          total_tax: calculate_total_tax(Array(order_item)),
          final_price: calculate_final_price(Array(order_item)),
          ordered_at: order.order_placed_at,
          delivered_at: order.delivered_at,
          time_passed_since_order_placed: time_passed_since_creation(order.order_placed_at),
          time_passed_since_delivered: time_passed_since_creation(order.delivered_at),
          created_at: order.created_at,
          updated_at: order.updated_at,
          accepted: order.accepted,
          order_status: BxBlockOrderManagement::OrderStatusSerializer.new(order.order_status),
          customer: AccountBlock::AccountSerializer.new(order.customer),
          seller: AccountBlock::AccountSerializer.new(@seller),
          shipping_address: get_delivery_address(order),
          coupon_code: BxBlockCouponCg::CouponCodeSerializer.new(order.coupon_code),
          shipped_order_details: order.shipped_order_details.map(&:serializable_hash),

          order_item: {
            id: order_item.id,
            catalogue_id: order_item.catalogue_id,
            price: order_item.price,
            quantity: order_item.quantity,
            discount_price: order_item.discount_price,
            taxable: order_item.taxable,
            taxable_value: order_item.taxable_value,
            accepted: order_item.accepted,
            order_status: BxBlockOrderManagement::OrderStatusSerializer.new(order_item.order_status),
            item: BxBlockCatalogue::CatalogueSerializer.new(
              catalogue
            ).serializable_hash[:data]

          }
        }
      end
      result = result.sort_by { |r| -(r[:ordered_at]&.to_time.to_i || 0) }
      result.push(total_count).compact
    end

    def render_order_items(order_items)
      BxBlockShoppingCart::OrderItemSerializer.new(order_items)
    end

    def filter_seller_order_items(order, fulfilled_by)
      if fulfilled_by
        order.order_items.select do |item|
          @seller.catalogues.map(&:id).include?(item.catalogue_id) && item.catalogue.fulfilled_type == params[:fulfilled_by]
        end
      else
        order.order_items.select { |item| @seller.catalogues.map(&:id).include?(item.catalogue_id) }
      end
    end

    def calculate_total_fees(order_items)
      order_items.map { |item| item.price * item.quantity }.sum || 0
    end

    def count_total_items(order_items)
      order_items.map { |item| item.quantity }.sum || 0
    end

    def calculate_total_discount(order_items)
      order_items.map { |item| item.discount_price * item.quantity }.sum || 0
    end

    def calculate_final_price(order_items)
      total_fees = if calculate_total_discount(order_items) > 0
                     [calculate_total_fees(order_items), calculate_final_discount_price(order_items)].min
                   else
                     calculate_total_fees(order_items) || 0.0
                   end
      total_tax = calculate_total_tax(order_items)

      total_fees + total_tax
    end

    def calculate_final_discount_price(order_items)
      final_discount = 0
      order_items.each do |item|
        final_discount += if item.discount_price > 0
                            (item.discount_price * item.quantity)
                          else
                            (item.price * item.quantity)
                          end
      end
      final_discount
    end

    def calculate_total_tax(order_items)
      order_items.map { |item| item.quantity * item.taxable_value }.reject(&:blank?).sum
    end

    def time_passed_since_creation(created_at)
      return 'N/A' unless created_at.present?

      distance_of_time_in_words(created_at, Time.now)
    end

    def custom_order_response(orders, order_item_status)
      return { message: 'No order present' } unless orders.present?

      order_items_collection = []

      orders.each do |order|
        order_items = if order_item_status.present?
                        order.order_items.includes(:order_status)
                             .where(order_statuses: { status: order_item_status.map(&:downcase).map(&:parameterize).map(&:underscore) })
                      else
                        order.order_items
                      end
        order_items.each do |order_item|
          order_items_collection << {
            order_details: {
              id: order.id,
              order_number: order.order_number,
              total_fees: order.total_fees,
              total_items: order.total_items,
              discount: order.discount,
              total_tax: order.total_tax,
              final_price: order.final_price,
              order_placed_at: order.order_placed_at,
              delivered_at: order.delivered_at,
              time_passed_since_order_placed: time_passed_since_creation(order.order_placed_at),
              time_passed_since_delivered: time_passed_since_creation(order.delivered_at),
              accepted: order.accepted,
              order_status: BxBlockOrderManagement::OrderStatusSerializer.new(order.order_status),
              customer: AccountBlock::AccountSerializer.new(order.customer),
              seller: AccountBlock::AccountSerializer.new(@seller),
              order_item_details: {
                id: order_item.id,
                price: order_item.price,
                quantity: order_item.quantity,
                taxable: order_item.taxable,
                taxable_value: order_item.taxable_value,
                accepted: order_item.accepted,
                order_status: BxBlockOrderManagement::OrderStatusSerializer.new(order_item.order_status),
                catalogue: BxBlockCatalogue::CatalogueSerializer.new(order_item.catalogue),
                selected_product_variant: if order_item.product_variant_group.present?
                                            {
                                              id: order_item.product_variant_group.id,
                                              product_sku: order_item.product_variant_group.product_sku,
                                              product_besku: order_item.product_variant_group.product_besku,
                                              group_attributes: order_item.product_variant_group.group_attributes&.group_by(&:attribute_name)&.map do |attribute_name, groups|
                                                {
                                                  attribute_name: attribute_name,
                                                  options: groups.map(&:option)
                                                }
                                              end
                                            }
                                          end
              },
              shipping_address: get_delivery_address(order),
              coupon_code: BxBlockCouponCg::CouponCodeSerializer.new(order.coupon_code),
              return_reason_details: order_item.return_reason_details.map { |rrd| rrd.serializable_hash },
              shipped_order_details: order_item.shipped_order_detail,
              return_exchange_requests: order_item.return_exchange_requests.map { |rer| rer.serializable_hash }
            }
          }
        end
      end

      order_items_collection
    end

    def order_activity_log(user, action, details)
      BxBlockActivitylog::ActivityLog.create(
        user: user,
        action: action,
        details: details,
        accessed_at: Time.current
      )
    end
  end
end