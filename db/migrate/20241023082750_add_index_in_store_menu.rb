class AddIndexInStoreMenu < ActiveRecord::Migration[6.0]
  def change
  	add_index :store_menus, :store_name
    add_index :store_menus, :title
    add_index :store_menus, :banner_name
    add_index :store_menus, :position
    add_index :store_menus, :product_quantity

    add_index :stores, :store_name
    add_index :stores, :store_year
    add_index :stores, :store_url
    add_index :stores, :website_social_url
    add_index :stores, :approve
    add_index :stores, :account_id
  end
end
