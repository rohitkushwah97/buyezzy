class RemoveCategoriesSubCategoriesTable < ActiveRecord::Migration[6.0]
  def change

  	remove_foreign_key :categories_sub_categories, :categories, column: :category_id

    drop_table :categories_sub_categories

  end
end
