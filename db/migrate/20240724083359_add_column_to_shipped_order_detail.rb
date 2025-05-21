class AddColumnToShippedOrderDetail < ActiveRecord::Migration[6.0]
  def change
  	add_column :shipped_order_details, :courier_name, :string
  	add_column :shipped_order_details, :tracking_number, :string
  	add_index :shipped_order_details, :courier_name
  	add_index :shipped_order_details, :tracking_number
  end
end
