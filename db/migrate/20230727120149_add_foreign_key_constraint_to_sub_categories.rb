class AddForeignKeyConstraintToSubCategories < ActiveRecord::Migration[6.0]
	def change
		add_foreign_key :sub_categories, :categories, column: :parent_id, on_delete: :cascade
		add_foreign_key :mini_categories, :sub_categories, column: :sub_category_id, on_delete: :cascade
		add_foreign_key :micro_categories, :mini_categories, column: :mini_category_id, on_delete: :cascade
	end
end
