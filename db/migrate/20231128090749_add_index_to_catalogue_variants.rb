class AddIndexToCatalogueVariants < ActiveRecord::Migration[6.0]
  def change
  	add_reference :catalogue_variants, :catalogue, null: false, foreign_key: { on_delete: :cascade }
  	add_index :catalogue_variants, :group_name
  end
end
