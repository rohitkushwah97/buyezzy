class RemoveSubCategoryIdFromCatalogues < ActiveRecord::Migration[6.0]
	def change
		remove_column :catalogues, :sub_category_id
		remove_column :catalogues, :new_stock
		remove_column :catalogues, :processing_time
	end
end
