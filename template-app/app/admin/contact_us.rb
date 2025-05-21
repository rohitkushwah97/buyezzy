ActiveAdmin.register BxBlockHelpCentre::ContactUs, as: 'Contact Us' do
  menu label: 'Contact Us'

  actions :index, :destroy, :show

  index do
    selectable_column
    id_column
    column :full_name
    column :email
    column :issue_type
    column :inquiry_details
    column 'Created At', :created_at
    column 'Updated At', :updated_at
    actions
  end

  show do
    attributes_table do
      row :full_name
      row :email
      row :issue_type
      row :inquiry_details
      row :created_at
      row :updated_at
    end
  end
end