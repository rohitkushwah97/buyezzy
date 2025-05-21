class AddAcceptedColumnToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_order_items, :accepted, :boolean, default: false
  end
end
