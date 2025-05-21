class AddAttachmentToAdminNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :admin_notifications, :attachment, null: true, foreign_key: { to_table: :active_storage_attachments }
  end
end