class AddColumnsToDealCatalogues < ActiveRecord::Migration[6.0]
	def change
		add_column :deal_catalogues, :seller_sku, :string
		add_column :deal_catalogues, :product_title, :string
		add_column :deal_catalogues, :seller_price, :decimal, precision: 10, scale: 2, default: 0.0
		add_column :deal_catalogues, :current_offer_price, :decimal, precision: 10, scale: 2, default: 0.0
		change_column_default :deal_catalogues, :deal_price, from: nil, to: 0.0
		add_index :deal_catalogues, :status
		add_index :deal_catalogues, :deal_price
		add_index :deal_catalogues, :seller_sku
		add_index :deal_catalogues, :product_title
		add_index :deal_catalogues, :seller_price
		add_index :deal_catalogues, :current_offer_price

		  #deal index 

		add_index :deals, :deal_name
		add_index :deals, :deal_code
		add_index :deals, :status
		add_index :deals, :discount_type
        add_column :deals, :discount_value, :decimal, precision: 10, scale: 2, default: 0.0
        add_index :deals, :discount_value

	end
end