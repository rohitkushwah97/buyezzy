module BxBlockSurveys
  class UpdateRetakeStatusJob < ApplicationJob 
    queue_as :default

    def perform(version)
      role = version.survey.role
      user_surveys = UserSurvey.includes(:account).where(role_id: role.id)
      return unless user_surveys.present?

      user_surveys.update(retake: true)
      heading = "New Version Created for #{role.name}"
      navigates_to = "RetakeQuizBusiness"
      content = "A new version (#{version.name}) has been created for the role #{role.name}. Please review and complete the pending quizzes."

      user_surveys.each do |user_survey|
        account = user_survey.account
        if account.type == "InternUser"
          notification_creator = BxBlockNotifications::NotificationCreator.new(account, heading, content, navigates_to)
          notification_creator.call
        else
          internships = account&.internships&.draft.where(role_id: role.id)
          if internships.present?
            internships.each do |internship|
              notification_creator = BxBlockNotifications::NotificationCreator.new(account, heading, content, navigates_to)
              notification_creator.call
            end
          end
        end
      end
    end
  end
end