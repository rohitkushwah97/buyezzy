class AddMicroCategoryToCatalogueVariant < ActiveRecord::Migration[6.0]
  def change
  	add_column :catalogue_variants, :micro_category_id, :bigint
  	add_index :catalogue_variants, :micro_category_id
  end
end
