class AddPurchasedCountToCatalogue < ActiveRecord::Migration[6.0]
  def change
  	add_column :catalogues, :purchased_count, :integer, default: 0
  	add_index :catalogues, :purchased_count
  end
end
