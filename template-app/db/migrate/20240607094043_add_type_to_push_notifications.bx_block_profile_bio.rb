# This migration comes from bx_block_profile_bio (originally 20210519080110)
# Protected File
# frozen_string_literal: true

# Add notify type migration
class AddTypeToPushNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :push_notifications, :notify_type, :string
  end
end
