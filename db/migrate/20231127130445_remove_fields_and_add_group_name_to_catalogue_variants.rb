class RemoveFieldsAndAddGroupNameToCatalogueVariants < ActiveRecord::Migration[6.0]
  def change
  	remove_column :catalogue_variants, :catalogue_id
    remove_column :catalogue_variants, :catalogue_variant_color_id
    remove_column :catalogue_variants, :catalogue_variant_size_id
    remove_column :catalogue_variants, :price
    remove_column :catalogue_variants, :stock_qty
    remove_column :catalogue_variants, :on_sale
    remove_column :catalogue_variants, :sale_price
    remove_column :catalogue_variants, :discount_price
    remove_column :catalogue_variants, :length
    remove_column :catalogue_variants, :breadth
    remove_column :catalogue_variants, :height
    remove_column :catalogue_variants, :block_qty

    add_column :catalogue_variants, :group_name, :string
  end
end
