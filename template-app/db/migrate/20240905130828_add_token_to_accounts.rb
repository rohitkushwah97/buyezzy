class AddTokenToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :token, :string
  end
end
