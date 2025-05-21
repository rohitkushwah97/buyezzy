class AddDiscountToShoppingCartOrderItems < ActiveRecord::Migration[6.0]
  def change
  	add_column :shopping_cart_order_items, :discount_price, :decimal, default: 0.0
  end
end
