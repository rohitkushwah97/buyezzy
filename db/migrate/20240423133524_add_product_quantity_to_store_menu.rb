class AddProductQuantityToStoreMenu < ActiveRecord::Migration[6.0]
  def change
    add_column :store_menus, :product_quantity, :integer
  end
end
