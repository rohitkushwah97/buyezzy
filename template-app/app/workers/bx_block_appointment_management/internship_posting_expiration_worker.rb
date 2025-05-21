module BxBlockAppointmentManagement
  class InternshipPostingExpirationWorker
    include Sidekiq::Worker

    def perform
      internships = BxBlockNavmenu::Internship.active
                    .includes(business_user: :notification_setting)
                    .where(start_date: 2.days.from_now.to_date)
      internships.each do |internship|
        if internship.business_user&.notification_setting&.turn_off_expiration_alerts
          send_notification(internship)
        end
      end
    end

    private

    def send_notification(internship)
      heading = "Listing Expiration Alert"
      navigates_to = "InternshipExpiration"
      content = "Your internship listing for [#{internship.title}] will expire in 2 days. Extend or update the listing if needed."
      notification_creator = BxBlockNotifications::NotificationCreator.new(internship.business_user, heading, content, navigates_to)
      notification_creator.call
    end
  end
end
