class AddShippingAddressDetailsToOrders < ActiveRecord::Migration[6.0]
	def change
  	#to store static shipped address after ordered
  	add_column :shopping_cart_orders, :shipping_first_name, :string
  	add_column :shopping_cart_orders, :shipping_last_name, :string
  	add_column :shopping_cart_orders, :shipping_address_1, :string
  	add_column :shopping_cart_orders, :shipping_address_2, :string
  	add_column :shopping_cart_orders, :shipping_city, :string
  	add_column :shopping_cart_orders, :shipping_state, :string
  	add_column :shopping_cart_orders, :shipping_phone_number, :string
  	add_column :shopping_cart_orders, :shipping_zip_code, :string

  	add_index :shopping_cart_orders, :shipping_first_name
  	add_index :shopping_cart_orders, :shipping_last_name
  	add_index :shopping_cart_orders, :shipping_address_1
  	add_index :shopping_cart_orders, :shipping_address_2
  	add_index :shopping_cart_orders, :shipping_city
  	add_index :shopping_cart_orders, :shipping_phone_number

  	add_index :user_delivery_addresses, :first_name
  	add_index :user_delivery_addresses, :last_name
  	add_index :user_delivery_addresses, :address_1
  	add_index :user_delivery_addresses, :address_2
  	add_index :user_delivery_addresses, :city
  	add_index :user_delivery_addresses, :state
  	add_index :user_delivery_addresses, :zip_code
  	add_index :user_delivery_addresses, :phone_number
  end
end
