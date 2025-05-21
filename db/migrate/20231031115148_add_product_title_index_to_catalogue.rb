class AddProductTitleIndexToCatalogue < ActiveRecord::Migration[6.0]
  def change
  	add_index :catalogues, :product_title
  end
end
