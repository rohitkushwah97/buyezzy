FactoryBot.define do
  factory :admin_notification, class: 'BxBlockNotifications::AdminNotification' do
    message { 'Test Notification' }

    trait :with_attachment do
      after(:create) do |notification|
        file = Rails.root.join('spec/fixtures/files/user.csv')
        notification.attachment.attach(io: File.open(file), filename: 'user.csv', content_type: 'text/csv')
      end
    end
  end
end
