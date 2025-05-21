class AddPositionColumnToStoreMenu < ActiveRecord::Migration[6.0]
  def change
  	add_column :store_menus, :position, :integer, default: 1
  end
end
