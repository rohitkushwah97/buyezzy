class DropExistingTablesAndColumns < ActiveRecord::Migration[6.0]
	def change
		
		drop_table :header_categories, if_exists: true
		drop_table :shipped_order_details, if_exists: true
		drop_table :return_exchange_requests, if_exists: true
		drop_table :order_items_return_exchange_requests, if_exists: true

		remove_column :catalogues, :is_variant, :boolean if column_exists?(:catalogues, :is_variant)
		remove_column :catalogues, :parent_product_id, :bigint if column_exists?(:catalogues, :parent_product_id)
		remove_column :product_variant_groups, :variant_product_id, :bigint if column_exists?(:product_variant_groups, :variant_product_id)

	end
end
