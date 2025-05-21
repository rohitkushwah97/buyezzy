class AddForeignKeysToProductVariantGroupAssociations < ActiveRecord::Migration[6.0]
  def change
  	remove_foreign_key :group_attributes, :product_variant_groups
    add_foreign_key :group_attributes, :product_variant_groups, on_delete: :cascade
  end
end
