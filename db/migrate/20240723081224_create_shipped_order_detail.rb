class CreateShippedOrderDetail < ActiveRecord::Migration[6.0]
	def change
		create_table :shipped_order_details do |t|
			t.text :shipping_details
			t.references :order, null: false, foreign_key: { to_table: :shopping_cart_orders }

			t.timestamps
		end
	end
end
