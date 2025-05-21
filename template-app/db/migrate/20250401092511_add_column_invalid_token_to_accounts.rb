class AddColumnInvalidTokenToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :invalid_tokens, :string, array: true, default: []
  end
end
