class AddColumnToBrandAndStore < ActiveRecord::Migration[6.0]
  def change
  	add_column :brands, :approve, :boolean
  	add_column :stores, :approve, :boolean
  end
end
