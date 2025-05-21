class AddAccountToRestrictedBrand < ActiveRecord::Migration[6.0]
  def change
  	add_reference :restricted_brands, :seller, null: false, foreign_key: { to_table: :accounts }
  end
end
