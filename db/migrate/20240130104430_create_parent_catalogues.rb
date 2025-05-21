class CreateParentCatalogues < ActiveRecord::Migration[6.0]
  def change
    create_table :parent_catalogues do |t|
      t.bigint :category_id, null: false
      t.bigint :brand_id, null: false
      t.string :sku
      t.string :besku
      t.string :prod_model_no
      t.string :details
      t.boolean :status
      t.string :product_title
      t.bigint :sub_category_id
      t.bigint :mini_category_id
      t.bigint :micro_category_id
      t.bigint :admin_id

      t.index :category_id
      t.index :brand_id
      t.index :sku
      t.index :besku
      t.index :sub_category_id
      t.index :mini_category_id
      t.index :micro_category_id
      t.index :admin_id
      t.index :product_title
      t.index :prod_model_no
      t.index :details

      t.timestamps
    end
  end
end
