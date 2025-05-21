class AddNavigatesToInNotificationTable < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :navigates_to, :string
  end
end
