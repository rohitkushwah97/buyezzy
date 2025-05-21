class AddAddressToWarehouse < ActiveRecord::Migration[6.0]
  def change
  	rename_column :warehouses, :warehouse_address, :warehouse_address_1
    add_column :warehouses, :warehouse_address_2, :string

    add_index :warehouses, :account_id
    add_index :warehouses, :warehouse_name
    add_index :warehouses, :contact_number
    add_index :warehouses, :contact_person
    add_index :warehouses, :processing_days
  end
end
