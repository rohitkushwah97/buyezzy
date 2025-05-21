FactoryBot.define do
  sequence(:notification_setting_name) { |n| "notification_setting_#{n}" }
  sequence(:notification_group_name) { |n| "notification_group_#{n}" }
  sequence(:notification_subgroup_name) { |n| "notification_subgroup_#{n}" }
end
