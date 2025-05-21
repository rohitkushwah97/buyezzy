class AddOrderStatusToOrderItem < ActiveRecord::Migration[6.0]
  def change
  	add_reference :shopping_cart_order_items, :order_status, foreign_key: true
  end
end
