class CreateWarehouseCatalogues < ActiveRecord::Migration[6.0]
  def change
    create_table :warehouse_catalogues do |t|
    	t.references :warehouse, null: false, foreign_key: { to_table: :warehouses }
    	t.references :catalogue, null: false, foreign_key: { to_table: :catalogues }
    	t.references :product_variant_group, null: true, foreign_key: { to_table: :product_variant_groups }
    	t.column :stocks, :integer, default: 0
    	t.index :stocks

    	t.timestamps
    end
  end
end
