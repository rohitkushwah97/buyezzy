class AddAccountIdToBrands < ActiveRecord::Migration[6.0]
  def change
  	remove_column :brands, :account_id, :integer
  	add_column :brands, :account_id, :integer, null: true, default: nil
  end
end
