module BxBlockAppointmentManagement
  class IncompleteApplicationsWorker
    include Sidekiq::Worker

    def perform
      internships = BxBlockNavmenu::Internship.draft
                    .includes(business_user: :notification_setting)

      internships.each do |internship|
        if internship.business_user&.notification_setting&.turn_off_incomplete_application_notifications

          days_since_created = (Time.current.to_date - internship.created_at.to_date).to_i

          if days_since_created % 7 == 0
            send_notification(internship)
          end
        end
      end
    end

    private

    def send_notification(internship)
      heading = "Incomplete Applications"
      navigates_to = "IncompleteDraft"
      content = "You have an internship [#{internship.title}] in draft mode waiting for review. Please check your applications."
      notification_creator = BxBlockNotifications::NotificationCreator.new(internship.business_user, heading, content, navigates_to)
      notification_creator.call
    end
  end
end
