class RemoveUnusefulFieldsFromCategory < ActiveRecord::Migration[6.0]
  def change
    remove_column :categories, :light_icon, :string
    remove_column :categories, :light_icon_active, :string
    remove_column :categories, :light_icon_inactive, :string
    remove_column :categories, :dark_icon, :string
    remove_column :categories, :dark_icon_active, :string
    remove_column :categories, :dark_icon_inactive, :string
    remove_column :categories, :identifier, :integer
  end
end
