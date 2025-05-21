class AddColumnsToCatalogueVariants < ActiveRecord::Migration[6.0]
  def change
  	rename_column :catalogue_variants, :catalogue_id, :seller_id
  end
end
