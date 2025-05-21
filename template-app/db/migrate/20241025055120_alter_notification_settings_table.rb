class AlterNotificationSettingsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :notification_settings, :title
    remove_column :notification_settings, :description
    remove_column :notification_settings, :state
    add_column :notification_settings, :account_id, :bigint
    add_column :notification_settings, :turn_off_deadline_reminders, :boolean, default: true
    add_column :notification_settings, :turn_off_perfect_match_notifications, :boolean, default: true
    add_column :notification_settings, :turn_off_recommendation_notifications, :boolean, default: true
    add_column :notification_settings, :turn_off_shortlist_notifications, :boolean, default: true
    add_column :notification_settings, :turn_off_application_status_updates, :boolean, default: true
    add_column :notification_settings, :turn_off_updates_on_saved_internships, :boolean, default: true
    add_column :notification_settings, :turn_off_feedback_notifications, :boolean, default: true
    add_column :notification_settings, :turn_off_interview_invitations, :boolean, default: true
    add_column :notification_settings, :turn_off_internview_reminders, :boolean, default: true
    add_column :notification_settings, :turn_off_new_application_alerts, :boolean, default: true
    add_column :notification_settings, :turn_off_incomplete_application_notifications, :boolean, default: true
    add_column :notification_settings, :turn_off_interview_notifications, :boolean, default: true
    add_column :notification_settings, :turn_off_expiration_alerts, :boolean, default: true
    add_column :notification_settings, :turn_off_interview_reminders, :boolean, default: true
    add_column :notification_settings, :turn_off_feedback_requests, :boolean, default: true
  end
end
