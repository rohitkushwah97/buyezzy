module BxBlockWishlist
  class WishlistSerializer < BuilderBase::BaseSerializer
    include Rails.application.routes.url_helpers

    attributes :id, :account_id, :created_at, :updated_at

    attribute :item do |object|
      BxBlockItem::ItemSerializer.new(object.item).serializable_hash
    end
  end
end
