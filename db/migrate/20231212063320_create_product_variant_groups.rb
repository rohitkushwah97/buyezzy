class CreateProductVariantGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variant_groups do |t|
      t.string :product_sku
      t.string :product_description
      t.decimal :price
      t.string :product_title
      t.references :catalogue, null: false, foreign_key: { on_delete: :cascade }
      t.index :product_sku
      t.index :product_title

      t.timestamps
    end
  end
end
