module BxBlockNotifications
    class AdminNotification < ApplicationRecord
      self.table_name = :admin_notifications
      has_one_attached :attachment
  
      # Add validations or associations if needed
    end
  end
  