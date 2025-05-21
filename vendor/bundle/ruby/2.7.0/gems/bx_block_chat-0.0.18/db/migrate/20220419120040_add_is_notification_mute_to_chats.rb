class AddIsNotificationMuteToChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :is_notification_mute, :boolean, default: true
  end
end
