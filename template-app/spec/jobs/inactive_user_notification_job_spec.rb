require 'rails_helper'

RSpec.describe AccountBlock::InactiveUserNotificationJob, type: :job do
  include ActiveSupport::Testing::TimeHelpers
  include ActiveJob::TestHelper 
  
  describe 'perform job after 15 minutes of inactivity' do
    it 'sends email' do
      ActionMailer::Base.deliveries.clear

      user = FactoryBot.create(:intern_user, 
        email: 'test@gmail.com', 
        last_visit_at: 15.5.minutes.ago)
      
      current_time = Time.current

      original_method = AccountBlock::Account.method(:where)
      allow(AccountBlock::Account).to receive(:where) do |*args|
        result = original_method.call(*args)

        result.each do |r|
          puts "  - User ID: #{r.id}, Email: #{r.email}, Last visit: #{r.last_visit_at}"
        end
        result
      end
      
      allow(File).to receive(:read).with(Rails.root.join("app/assets/images/image_.png")).and_return("fake image content")
      
      perform_enqueued_jobs do
        AccountBlock::InactiveUserNotificationJob.perform_now
      end
   
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end