class AddDiscountColumnToOrder < ActiveRecord::Migration[6.0]
  def change
  	add_column :shopping_cart_orders, :discount, :float, default: 0.0
  end
end
