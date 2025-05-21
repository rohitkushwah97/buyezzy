# Protected File
class RemoveColumnIsNotificationMutedFromChats < ActiveRecord::Migration[6.0]
  def change
    remove_column :chats, :is_notification_mute, :boolean, default: false
  end
end
