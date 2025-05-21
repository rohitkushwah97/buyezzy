module BxBlockFavourites
  class Favourite < BxBlockFavourites::ApplicationRecord
    self.table_name = :favourites

    belongs_to :favouriteable, polymorphic: true
    belongs_to :user, class_name: "AccountBlock::Account", foreign_key: "user_id"
    belongs_to :product_variant_group, class_name: 'BxBlockCatalogue::ProductVariantGroup', optional: true

  end
end
