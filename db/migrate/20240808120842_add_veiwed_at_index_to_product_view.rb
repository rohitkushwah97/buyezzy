class AddVeiwedAtIndexToProductView < ActiveRecord::Migration[6.0]
  def change
  	add_index :product_views, :viewed_at
  end
end
