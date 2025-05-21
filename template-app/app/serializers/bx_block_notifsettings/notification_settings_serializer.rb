module BxBlockNotifsettings
  class NotificationSettingsSerializer < BuilderBase::BaseSerializer
    attributes  :turn_off_deadline_reminders, :turn_off_perfect_match_notifications, :turn_off_recommendation_notifications,
      :turn_off_shortlist_notifications, :turn_off_application_status_updates, :turn_off_updates_on_saved_internships,
      :turn_off_feedback_notifications, :turn_off_interview_invitations, :turn_off_internview_reminders,
      :turn_off_new_application_alerts, :turn_off_incomplete_application_notifications,
      :turn_off_interview_notifications, :turn_off_expiration_alerts, :turn_off_interview_reminders,
      :turn_off_feedback_requests, :created_at, :updated_at
  end
end

