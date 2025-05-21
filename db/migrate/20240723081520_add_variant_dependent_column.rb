class AddVariantDependentColumn < ActiveRecord::Migration[6.0]
	def change
		add_column :catalogues, :is_variant, :boolean, default: false
		add_index :catalogues, :is_variant
		add_column :catalogues, :parent_product_id, :bigint
		add_index :catalogues, :parent_product_id
		add_column :product_variant_groups, :variant_product_id, :bigint
		add_index :product_variant_groups, :variant_product_id
	end
end
