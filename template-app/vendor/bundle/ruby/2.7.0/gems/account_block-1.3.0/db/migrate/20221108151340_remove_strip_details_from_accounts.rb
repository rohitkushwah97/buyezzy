# Protected File
class RemoveStripDetailsFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :stripe_id
    remove_column :accounts, :stripe_subscription_id
    remove_column :accounts, :stripe_subscription_date
  end
end
