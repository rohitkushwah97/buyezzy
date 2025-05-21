module BxBlockShoppingCart
  class OrderSerializer < BuilderBase::BaseSerializer
    extend BxBlockShoppingCart::OrderConcern

    attributes *[
        :id,
        :order_number,
        :status,
        :total_fees,
        :total_items,
        :discount,
        :total_tax,
        :final_price,
        :order_placed_at,
        :delivered_at,
        :accepted,
        :created_at,
        :updated_at
    ]

    attribute :order_status do |object|
      BxBlockOrderManagement::OrderStatusSerializer.new(object.order_status)
    end

    attribute :order_items do |object|
      BxBlockShoppingCart::OrderItemSerializer.new(object.order_items.order(created_at: :desc))
    end

    attribute :customer do |object|
      AccountBlock::AccountSerializer.new(object.customer)
    end

    attribute :shipping_address do |object|
      get_delivery_address(object)
    end

    attribute :shipped_order_details do |object|
        if object.shipped_order_details
          object.shipped_order_details.order(created_at: :desc).map do |shipped_order_detail|
            {
                id: shipped_order_detail.id,
                shipping_details: shipped_order_detail.shipping_details,
                order_id: shipped_order_detail.order_id
            }
          end
        end
    end

    attribute :coupon_code do |object|
      BxBlockCouponCg::CouponCodeSerializer.new(object.coupon_code)
    end

    # attribute :sellers do |object|
    #   AccountBlock::AccountSerializer.new(object.sellers)
    # end

    # class << self
    #   def order_services_for order
    #     order.sub_categories.pluck(:name)
    #     # order.services.map{|service| service.sub_category.name }
    #   end
    # end
  end
end
