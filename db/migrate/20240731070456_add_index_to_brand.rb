class AddIndexToBrand < ActiveRecord::Migration[6.0]
	def change
		add_index :brands, :brand_name
		add_index :brands, :brand_name_arabic
		add_index :brands, :approve
		add_index :brands, :restricted
		add_index :brands, :account_id
	end
end
