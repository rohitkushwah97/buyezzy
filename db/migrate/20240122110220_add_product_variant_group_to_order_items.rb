class AddProductVariantGroupToOrderItems < ActiveRecord::Migration[6.0]
	def change
		add_column :shopping_cart_order_items, :product_variant_group_id, :bigint
		add_foreign_key :shopping_cart_order_items, :product_variant_groups, column: :product_variant_group_id, on_delete: :cascade
		add_index :shopping_cart_order_items, :order_id
		add_index :shopping_cart_order_items, :catalogue_id
		add_index :shopping_cart_order_items, :price
		add_index :shopping_cart_order_items, :quantity
		add_index :shopping_cart_order_items, :product_variant_group_id
	end
end
