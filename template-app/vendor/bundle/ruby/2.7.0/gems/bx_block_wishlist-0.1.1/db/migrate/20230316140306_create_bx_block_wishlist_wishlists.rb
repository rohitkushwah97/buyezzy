class CreateBxBlockWishlistWishlists < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_wishlist_wishlists do |t|
      t.references :account, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
