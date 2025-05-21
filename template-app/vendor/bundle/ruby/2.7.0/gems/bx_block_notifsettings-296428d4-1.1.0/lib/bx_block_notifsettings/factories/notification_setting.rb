FactoryBot.define do
  factory :notification_setting,
          :class => 'BxBlockNotifsettings::NotificationSetting' do
    title { generate :notification_setting_name }
    description { 'Notification setting description' }
    state { 'active' }
  end
end
