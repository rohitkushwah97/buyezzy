class AddFinalPriceToCatalogues < ActiveRecord::Migration[6.0]
  def change
  	# changed precision to 15 because existing data contains dummy which not able find 
  	add_column :catalogues, :final_price, :decimal, precision: 15, scale: 2, default: 0.0
  	add_index :catalogues, :final_price
  end
end
