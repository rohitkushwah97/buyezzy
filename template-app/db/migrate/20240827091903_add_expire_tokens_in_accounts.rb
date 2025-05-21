class AddExpireTokensInAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :expire_tokens, :string, array: true, default: [] 
  end
end
