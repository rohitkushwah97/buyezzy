ActiveAdmin.register BxBlockNotifications::AdminNotification, as: 'Admin Notification' do
  menu label: 'Notification'

  filter :message
  filter :created_at
  filter :updated_at 
  actions :index, :destroy, :show
  index do
    selectable_column
    id_column
    column :message
    column 'Created At', :created_at
    column 'Updated At', :updated_at
    column 'Attachment' do |notification|
      if notification.attachment.attached?
        link_to notification.attachment.filename.to_s, rails_blob_path(notification.attachment, disposition: 'attachment')
      end
    end
    actions
  end

  show do
    attributes_table do
      row :message
      row :created_at
      row :updated_at
      row :attachment do |notification|
        if notification.attachment.attached?
          link_to notification.attachment.filename.to_s, rails_blob_path(notification.attachment, disposition: 'attachment')
        end
      end
    end
  end
end