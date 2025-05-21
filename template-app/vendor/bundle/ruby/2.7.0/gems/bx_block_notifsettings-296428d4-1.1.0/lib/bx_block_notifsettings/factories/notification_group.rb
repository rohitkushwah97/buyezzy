FactoryBot.define do
  factory :notification_group,
          :class => 'BxBlockNotifsettings::NotificationGroup' do
    notification_setting_id { (create :notification_setting).id }
    group_type { 'account_group' }
    group_name { generate :notification_group_name }
    state { 'active' }
  end
end
