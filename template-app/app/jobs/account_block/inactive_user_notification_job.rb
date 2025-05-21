module AccountBlock
  class InactiveUserNotificationJob < ApplicationJob
    queue_as :default

    def perform
      # inactive_users = Account.where("last_visit_at <= ?", 1.day.ago)
      # inactive_users = Account.where("last_visit_at <= ?", 1.minutes.ago)
      inactive_users = Account.where("last_visit_at <= ? AND last_visit_at > ?", 15.minutes.ago, 16.minutes.ago)
      inactive_users.find_each do |user|
      next if user.email.blank?
        AccountBlock::AccountActivationMailer.with(otp: user).inactivity_email.deliver_later
      end
    end
  end
end