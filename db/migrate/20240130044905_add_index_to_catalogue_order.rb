class AddIndexToCatalogueOrder < ActiveRecord::Migration[6.0]
	def change
		add_index :catalogues, :sku
		add_index :catalogues, :besku
		add_index :catalogues, :sub_category_id
		add_index :catalogues, :mini_category_id
		add_index :catalogues, :micro_category_id
		add_index :catalogues, :seller_id

		add_index :shopping_cart_orders, :address_id
		add_index :shopping_cart_orders, :total_fees
		add_index :shopping_cart_orders, :total_items
		add_index :shopping_cart_orders, :final_price
		add_index :shopping_cart_orders, :order_number
		add_index :shopping_cart_orders, :order_status_id
		add_index :shopping_cart_orders, :order_placed_at
		add_index :shopping_cart_orders, :delivered_at

		add_index :product_contents, :gtin
		add_index :product_contents, :unique_psku
		add_index :product_contents, :product_title
		add_index :product_contents, :mrp
		add_index :product_contents, :retail_price

	end
end
