class AddOrderStatusIdToShoppingCartOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :order_status_id, :bigint
  end
end
