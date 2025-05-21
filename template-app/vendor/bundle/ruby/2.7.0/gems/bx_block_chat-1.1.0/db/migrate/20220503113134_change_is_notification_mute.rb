# Protected File
class ChangeIsNotificationMute < ActiveRecord::Migration[6.0]
  def change
    change_column :chats, :is_notification_mute, :boolean, default: false
  end
end
