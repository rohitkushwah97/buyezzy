# Protected File
class RemoveColumnFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :is_paid, :boolean
  end
end
