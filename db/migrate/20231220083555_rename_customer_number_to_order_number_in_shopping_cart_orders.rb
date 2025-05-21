class RenameCustomerNumberToOrderNumberInShoppingCartOrders < ActiveRecord::Migration[6.0]
	def up
		change_column :shopping_cart_orders, :customer_number, :string
		rename_column :shopping_cart_orders, :customer_number, :order_number
	end

	def down
		change_column :shopping_cart_orders, :order_number, :integer
		rename_column :shopping_cart_orders, :order_number, :customer_number
	end
end
