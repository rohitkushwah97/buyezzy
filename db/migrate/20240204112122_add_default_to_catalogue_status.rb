class AddDefaultToCatalogueStatus < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :catalogues, :status, from: nil, to: false
  end
end
