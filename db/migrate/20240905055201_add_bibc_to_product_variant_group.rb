class AddBibcToProductVariantGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variant_groups, :product_bibc, :string
    add_index :product_variant_groups, :product_bibc
  end
end
