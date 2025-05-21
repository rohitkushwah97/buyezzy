class AddShippedOrderItemsidToShippedDetailsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :shipped_order_details, :order_item_id, :integer
    change_column_null :shipped_order_details, :order_id, true
  end
end
