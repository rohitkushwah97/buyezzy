class AddTransactionIdToOrders < ActiveRecord::Migration[6.0]
  def change
  	add_column :shopping_cart_orders, :transaction_id, :string
  	add_index :shopping_cart_orders, :transaction_id
  end
end
