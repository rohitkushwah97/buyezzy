class AddIndexToOrderStatus < ActiveRecord::Migration[6.0]
  def change
  	add_index :order_statuses, :name
  	add_index :order_statuses, :status
  end
end
