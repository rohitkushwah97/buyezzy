module BxBlockNotifications
  class PendingSurveyNotificationWorker
    include Sidekiq::Worker

    def perform
      career_interests =  BxBlockProfile::CareerInterest.includes(:user_survey,:intern_user).where(user_surveys:{quiz_status: "pending"})

      career_interests.each do |career_interest|
        days_since_created = (Time.current.to_date - career_interest.created_at.to_date).to_i
 
        if days_since_created % 7 == 0
          send_notification(career_interest)
        end
      end
    end

    private

    def send_notification(career_interest)
      heading = "Pending quiz"
      content = "You have pending quiz. Answer now to apply for internships!"
      navigates_to = "PendingQuizIntern"
      notification_creator = BxBlockNotifications::NotificationCreator.new(career_interest.intern_user, heading, content, navigates_to)
      notification_creator.call
    end
  end
end