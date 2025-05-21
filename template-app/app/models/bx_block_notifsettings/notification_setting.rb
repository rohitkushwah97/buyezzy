module BxBlockNotifsettings
  class NotificationSetting < BxBlockNotifsettings::ApplicationRecord
    self.table_name = :notification_settings
    belongs_to :account, class_name: "AccountBlock::Account"
  end
end
