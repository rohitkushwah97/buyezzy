class AddWarehouseCodeToWarehouses < ActiveRecord::Migration[6.0]
  def change
    add_column :warehouses, :warehouse_code, :string
  end
end
