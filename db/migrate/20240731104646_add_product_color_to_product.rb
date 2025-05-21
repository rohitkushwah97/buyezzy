class AddProductColorToProduct < ActiveRecord::Migration[6.0]
  def change
  	add_column :product_contents, :product_color, :string
  	add_index :product_contents, :product_color
  end
end
