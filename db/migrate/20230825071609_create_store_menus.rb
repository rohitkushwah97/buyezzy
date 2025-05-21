class CreateStoreMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :store_menus do |t|
      t.string :title
      t.string :store_name
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
