class AddAccountIdToStores < ActiveRecord::Migration[6.0]
  def change
  	add_column :stores, :account_id, :integer, null: true, default: nil
  end
end
