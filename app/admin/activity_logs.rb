ActiveAdmin.register BxBlockActivitylog::ActivityLog, as: 'ActivityLogs' do

	actions :show, :index, :delete

	index do
		selectable_column
		id_column
		column :user_email
		column :user_type
		column :action
		column :accessed_at
		actions
	end

	filter :user
	filter :user_type
	filter :action
	filter :details
	filter :accessed_at

	show do
		attributes_table do
			row :user
			row :user_email
			row :user_type
			row :action
			row :details
			row :accessed_at
		end
	end

end