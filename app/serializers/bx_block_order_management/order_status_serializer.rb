module BxBlockOrderManagement
  class OrderStatusSerializer < BuilderBase::BaseSerializer
    attributes :name, :created_at, :updated_at
  end
end