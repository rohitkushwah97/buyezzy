class AddColumnToShoppingCartOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :customer_number, :integer
    add_reference :shopping_cart_orders, :coupon_code, null: true
  end
end
