class AddEmiratesIdInAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :emirates_id, :integer
  end
end
