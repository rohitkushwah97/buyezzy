class AddIndexToCatalogueStatus < ActiveRecord::Migration[6.0]
  def change
  	add_index :catalogues, :status
  end
end
