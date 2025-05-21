class AddCatalogueVariantToProductVariantGroup < ActiveRecord::Migration[6.0]
  def change
  	add_column :product_variant_groups, :catalogue_variant_id, :bigint
  	add_index :product_variant_groups, :catalogue_variant_id
  end
end
