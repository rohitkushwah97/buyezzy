ActiveAdmin.register BxBlockNotifications::Notification, as: 'InAppNotification' do
  actions :index, :show

  config.sort_order = 'created_at_desc'

  remove_filter :match_type, :navigates_to, :read_at, :is_read, :is_read, :app_url, :contents, :created_by


  index do
    id_column
    column :headings
    column :created_at
    column :account do |notification|
      account_link(notification.account)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :headings
      row :contents
      row :app_url
      row :is_read
      row :account do|notification|
       account_link(notification.account)
      end
      row :read_at
      row :navigates_to
      row :match_type
    end
  end

  controller do

    helper do
      def account_link(account)
        return unless account
        if account.type == "InternUser"
          link_to(account&.full_name, admin_intern_user_path(account))
        else
          link_to(account&.company_detail&.company_name, admin_business_user_path(account))
        end
      end
    end
  end
end