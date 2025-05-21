class AddSellerToDealCatalogue < ActiveRecord::Migration[6.0]
  def change
  	add_column :deal_catalogues, :seller_id, :bigint
  	add_index :deal_catalogues, :seller_id
  end
end
