class AddActionColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :accepted, :boolean, default: false
  end
end
