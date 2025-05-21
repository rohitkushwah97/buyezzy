class AddMatchTypeOnNotification < ActiveRecord::Migration[6.1]
  def change
     add_column :notifications, :match_type, :string
  end
end
