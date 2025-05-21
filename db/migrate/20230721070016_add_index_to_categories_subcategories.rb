class AddIndexToCategoriesSubcategories < ActiveRecord::Migration[6.0]
  def change
  	add_index :sub_categories, :name
  	add_index :categories, :name
  end
end
