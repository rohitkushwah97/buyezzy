class AddBannerNameToStoreMenu < ActiveRecord::Migration[6.0]
  def change
    add_column :store_menus, :banner_name, :string
  end
end
