class CreateJoinTableStoreMenusCatalogues < ActiveRecord::Migration[6.0]
  def change
    create_join_table :store_menus, :catalogues do |t|
      t.index [:store_menu_id, :catalogue_id]
      t.index [:catalogue_id, :store_menu_id]
    end
  end
end
