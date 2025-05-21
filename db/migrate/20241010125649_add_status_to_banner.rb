class AddStatusToBanner < ActiveRecord::Migration[6.0]
  def change
    add_column :banners, :status, :boolean, default: false
    add_index :banners, :status
    add_index :banners, :title
  end
end
