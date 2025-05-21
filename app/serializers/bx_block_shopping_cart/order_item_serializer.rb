module BxBlockShoppingCart
  class OrderItemSerializer < BuilderBase::BaseSerializer

    attributes *[
      :id,
      :order_id,
      :price,
      :quantity,
      :discount_price,
      :taxable,
      :taxable_value,
      :accepted
    ]

    attribute :order_status do |object|
      BxBlockOrderManagement::OrderStatusSerializer.new(object.order_status)
    end

    attribute :item do |object|
      {
        catalogue: BxBlockCatalogue::CatalogueSerializer.new(object.catalogue),
        selected_product_variant: if object.product_variant_group.present?
         {
          id: object.product_variant_group.id,
          product_sku: object.product_variant_group.product_sku,
          product_besku: object.product_variant_group.product_besku,
          group_attributes: object.product_variant_group.group_attributes&.group_by(&:attribute_name).map do |attr_name, groups|
            {
              attribute_name: attr_name,
              options: groups.map(&:option)
            }
          end
        }
      end,
        favourite: BxBlockShoppingCart::OrderItem.get_favourites(object)
      }
    end

    attribute :return_reason_details do |object|
      object.return_reason_details.map do |rrd|
        rrd.serializable_hash
      end
    end

    attribute :return_exchange_requests do |object|
      object.return_exchange_requests.map do |rer|
        rer.serializable_hash
      end
    end
  end
end