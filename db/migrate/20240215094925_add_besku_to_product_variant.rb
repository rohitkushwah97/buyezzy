class AddBeskuToProductVariant < ActiveRecord::Migration[6.0]
  def change
  	add_column :product_variant_groups, :product_besku, :string
  	add_index :product_variant_groups, :product_besku
  end
end
