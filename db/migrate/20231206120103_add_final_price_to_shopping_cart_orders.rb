class AddFinalPriceToShoppingCartOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :final_price, :float
  end
end
