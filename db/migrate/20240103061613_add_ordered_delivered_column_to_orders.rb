class AddOrderedDeliveredColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :order_placed_at, :datetime
    add_column :shopping_cart_orders, :delivered_at, :datetime
  end
end
