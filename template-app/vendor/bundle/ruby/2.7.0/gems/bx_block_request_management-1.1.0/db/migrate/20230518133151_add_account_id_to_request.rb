# Protected File
class AddAccountIdToRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :account_id, :bigint
  end
end
