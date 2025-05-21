FactoryBot.define do
  factory :notification, class: 'BxBlockNotifications::Notification' do
    created_by { create(:business_user).id }  # Assuming 'business_user' is a model associated with notifications
    headings { Faker::Lorem.sentence }
    contents { Faker::Lorem.paragraph }
    app_url { Faker::Internet.url }
    is_read { false }  # Default to false, can be overridden in specific tests
    read_at { nil }  # Will be set when the notification is marked as read
    association :account  # Assuming `account_id` is related to an `Account` model
    
    # timestamps are handled automatically by ActiveRecord, no need to set them explicitly
  end
end
