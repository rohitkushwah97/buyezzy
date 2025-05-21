class AddSubCategoryToCatalogue < ActiveRecord::Migration[6.0]
  def change
  	add_column :catalogues, :sub_category_id, :bigint
  	add_column :catalogues, :mini_category_id, :bigint
  	add_column :catalogues, :micro_category_id, :bigint
  end
end
