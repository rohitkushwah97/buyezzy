module BxBlockNotifsettings
  class NotificationSettingsController < ApplicationController
    before_action :validate_json_web_token, :authenticate_account, :get_setting

    def show
      success_response(@setting)
    end

    def update
      success_response(@setting) if @setting.update(setting_params)
    end

    private

    def setting_params
      params.permit(
        :turn_off_deadline_reminders, :turn_off_perfect_match_notifications, :turn_off_recommendation_notifications,
        :turn_off_shortlist_notifications, :turn_off_application_status_updates, :turn_off_updates_on_saved_internships,
        :turn_off_feedback_notifications, :turn_off_interview_invitations, :turn_off_internview_reminders,
        :turn_off_new_application_alerts, :turn_off_incomplete_application_notifications,
        :turn_off_interview_notifications, :turn_off_expiration_alerts, :turn_off_interview_reminders,
        :turn_off_feedback_requests
      )
    end

    def get_setting
      @setting = @current_user.notification_setting
      render json: {message: "Notification setting not found."}, status: 404 unless @setting.present?
    end

    def success_response(object, status = 200)
      res = NotificationSettingsSerializer.new(object).serializable_hash
      render json: res, status: status
    end

  end
end
