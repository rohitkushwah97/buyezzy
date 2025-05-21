FactoryBot.define do
  factory :notification_subgroup,
          :class => 'BxBlockNotifsettings::NotificationSubgroup' do
    notification_group_id { (create :notification_group).id }
    subgroup_type { 'wishlist_item_out_of_stock' }
    subgroup_name { generate :notification_subgroup_name }
    state { 'active' }
  end
end
