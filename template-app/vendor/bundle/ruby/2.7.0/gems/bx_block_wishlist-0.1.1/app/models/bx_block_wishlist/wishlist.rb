module BxBlockWishlist
  class Wishlist < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_wishlist_wishlists

    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :item, class_name: "BxBlockItem::Item"

    validates :item, presence: true, uniqueness: { scope: :account }
  end
end
