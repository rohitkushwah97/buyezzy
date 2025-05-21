class AddProductVariantGroupToFavourite < ActiveRecord::Migration[6.0]
  def change
  	add_column :favourites, :product_variant_group_id, :bigint
		add_foreign_key :favourites, :product_variant_groups, column: :product_variant_group_id, on_delete: :cascade
		add_index :favourites, :favouriteable_id
		add_index :favourites, :favouriteable_type
		add_index :favourites, :user_id
		add_index :favourites, :product_variant_group_id
  end
end
