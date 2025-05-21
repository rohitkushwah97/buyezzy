class AddDefaultValueToStocksInCatalogues < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :catalogues, :stocks, from: nil, to: 0
  end
end
