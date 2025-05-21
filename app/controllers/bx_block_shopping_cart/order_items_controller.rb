module BxBlockShoppingCart
  class OrderItemsController < ApplicationController
    include BxBlockShoppingCart::OrderConcern

    before_action :get_user, only: [:create, :destroy, :guest_user_order]
    before_action :find_or_build_order, only: [:create, :destroy, :guest_user_order]
    before_action :find_order_item, only: [:destroy]
    before_action :find_individual_order_item, only: [:update]
    before_action :find_order_status, only: [:update]
    before_action :get_seller, only: [:index]
    # before_action :get_service_provider, only: %i(get_booked_time_slots)

    def index
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1

      orders = Order.all.includes(:order_status)
      .joins(order_items: { catalogue: [:seller, :product_content]})
      .where('accounts.id': @seller.id).order(order_placed_at: :desc)

      order_items = orders.flat_map do |order|
        order.order_items.select do |item|
          item.order_status&.status&.in?(params[:filter_by].map(&:downcase).map(&:parameterize).map(&:underscore)) &&
          item.catalogue.seller_id == @seller.id
        end
      end.uniq

      filtered_order_item_ids = order_items.map(&:id).uniq

      if params[:search_query].present?
        search_query = params[:search_query].downcase
        filtered_order_item_ids = order_items.select do |item|
          item.catalogue.sku.downcase.include?(search_query) ||
          item.order.order_number.downcase.include?(search_query)
        end.map(&:id).uniq
      end

      order_items = OrderItem.where(id: filtered_order_item_ids)
      total_count = order_items.count

      case params[:sort_by]
      when 'date_oldest'
        order_items = order_items.order(updated_at: :asc)
      when 'product_name_AZ'
        order_items = order_items.joins(catalogue: :product_content).order('product_contents.product_title ASC')
      when 'product_name_ZA'
        order_items = order_items.joins(catalogue: :product_content).order('product_contents.product_title DESC')
      else
        order_items = order_items.order(updated_at: :desc)
      end

      if order_items.present?
        order_items = order_items.page(page_number).per(per_page)
      end

      render json: {total_count: total_count, orders: custom_order_items_response(order_items)}
    end

    def create
      @order_item = find_or_build_order_item(params[:order_items][:catalogue_id])

      if @order_item.present? && params[:order_items][:shopping_cart]
        @order_item.update(order_items_params)
      elsif @order_item
        @order_item.quantity += order_items_params.delete(:quantity).to_i
        @order_item.update(order_items_params.except(:quantity,:shopping_cart))
      else
        @order_item = @order.order_items.create(order_items_params)
      end
      if @order_item.errors.present?
        render json: {
          errors: @order_item.errors
        }, status: :unprocessable_entity
      else
        @order.reload
        render json: BxBlockShoppingCart::OrderSerializer.new(@order).serializable_hash, status: 201
      end
    end

    def update
      if @order_item.update(order_status: @order_status)
        render json: OrderItemSerializer.new(@order_item).serializable_hash , status: :ok
      else
        render json: {
          errors: format_activerecord_errors(@order_item.errors)
        }, status: :unprocessable_entity
      end
    end

    def guest_user_order
      if params[:order_items].present?
        params[:order_items].each do |order_item_params|
          permitted_params = order_item_params.permit(:catalogue_id, :product_variant_group_id, :quantity)
          @order_item = find_or_build_order_item(permitted_params[:catalogue_id])

          catalogue = BxBlockCatalogue::Catalogue.find_by(id: permitted_params[:catalogue_id])
          available_stock = catalogue&.stocks || 0

          requested_quantity = @order_item ? @order_item.quantity + permitted_params[:quantity].to_i : permitted_params[:quantity].to_i
          final_quantity = [requested_quantity, available_stock].min

          if @order_item
            @order_item.update(quantity: final_quantity)
          else
            permitted_params[:quantity] = final_quantity
            @order_item = @order.order_items.create(permitted_params)
          end
        end

        @order.reload
        render json: {
          message: 'Order items added successfully',
          order: BxBlockShoppingCart::OrderSerializer.new(@order).serializable_hash
        }, status: :created
      else
        render json: {
          message: 'Provide valid products'
        }, status: :unprocessable_entity
      end
    end

    def destroy
      if @order_item.destroy
        @order.reload
        render json: {message: "Order items deleted successfully!"}, status: :ok
      else
        render json: {
          errors: format_activerecord_errors(@order_item.errors)
        }, status: :unprocessable_entity
      end
    end

    private

    def order_items_params
      params.require(:order_items).permit(
        :catalogue_id, :quantity, :taxable, :order_status_id,
        :taxable_value, :other_charges, :product_variant_group_id
      )
    end

    def get_user
      @customer = AccountBlock::Account.find(@token.id)
      render json: {errors: 'Customer is invalid'} and return unless @customer.present?
    end

    def find_or_build_order
      @order = @customer.orders.includes(:order_status).where(order_statuses: { status: ["on_going", "scheduled"] }).last
      @order ||= Order.create(customer_id: @customer.id)
    end

    def find_order_item
      @order_item = @order.order_items.find(params[:id])
    end

    def find_or_build_order_item(catalogue_id)
        @order.order_items.find_by(catalogue_id: catalogue_id)
    end

    def find_order_status
      @order_status = BxBlockOrderManagement::OrderStatus.find_by(id: params[:order_status_id])
      if @order_status.nil?
        render json: {
            message: "Order status not found"
          }, status: :not_found
      end
    end

    def find_individual_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def get_seller
      @seller = AccountBlock::Account.find_by(id: @token.id, user_type: 'seller')
      render json: {errors: 'seller is invalid'} and return unless @seller.present?
    end

    def custom_order_items_response(order_items)
      return { message: 'No return orders' } unless order_items.present?

      order_items.map do |order_item|
        {
          order_details: {
            id: order_item.order.id,
            order_number: order_item.order.order_number,
            total_fees: order_item.order.total_fees,
            total_items: order_item.order.total_items,
            discount: order_item.order.discount,
            total_tax: order_item.order.total_tax,
            final_price: order_item.order.final_price,
            order_placed_at: order_item.order.order_placed_at,
            delivered_at: order_item.order.delivered_at,
            time_passed_since_order_placed: time_passed_since_creation(order_item.order.order_placed_at),
            time_passed_since_delivered: time_passed_since_creation(order_item.order.delivered_at),
            accepted: order_item.order.accepted,
            order_status: BxBlockOrderManagement::OrderStatusSerializer.new(order_item.order.order_status),
            customer: AccountBlock::AccountSerializer.new(order_item.order.customer),
            seller: AccountBlock::AccountSerializer.new(@seller),
            order_item_details: {
              id: order_item.id,
              price: order_item.price,
              quantity: order_item.quantity,
              taxable: order_item.taxable,
              taxable_value: order_item.taxable_value,
              order_status: BxBlockOrderManagement::OrderStatusSerializer.new(order_item.order_status),
              catalogue: BxBlockCatalogue::CatalogueSerializer.new(order_item.catalogue),
              selected_product_variant: order_item.product_variant_group.present? ? {
                id: order_item.product_variant_group.id,
                product_sku: order_item.product_variant_group.product_sku,
                product_besku: order_item.product_variant_group.product_besku,
                group_attributes: order_item.product_variant_group.group_attributes&.group_by(&:attribute_name).map do |attribute_name, groups|
                  {
                    attribute_name: attribute_name,
                    options: groups.map(&:option)
                  }
                end
              } : nil,
            },
            shipping_address: get_delivery_address(order_item.order),
            coupon_code: BxBlockCouponCg::CouponCodeSerializer.new(order_item.order.coupon_code),
            return_reason_details: order_item.return_reason_details.map {|rrd| rrd.serializable_hash},
            return_exchange_requests: order_item.return_exchange_requests.map {|rer| rer.serializable_hash}
          }
        }
      end
    end

    def time_passed_since_creation(created_at)
      return 'N/A' unless created_at.present?

      distance_of_time_in_words(created_at, Time.now)
    end
  end
end
