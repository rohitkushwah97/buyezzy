module BxBlockOrderManagement
  class DeliveryRequestSerializer < BuilderBase::BaseSerializer
    attributes :id, :warehouse_id, :warehouse_name, :seller_id, :order_id, :order_number, :address_1, :address_2, :status, :created_at, :updated_at

    attribute :sellers do |object|
      AccountBlock::AccountSerializer.new(object.seller)
    end

    attribute :warehouse do |object|
      BxBlockCatalogue::WarehouseSerializer.new(object.warehouse)
    end

  end
end