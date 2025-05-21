class CreateWarehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :warehouses do |t|
      t.string :warehouse_type
      t.string :warehouse_name
      t.string :warehouse_address

      t.timestamps
    end
  end
end
