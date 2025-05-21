ActiveAdmin.register BxBlockHelpCentre::IssueType, as: 'Issue Type' do
  menu label: 'Issue Types', parent: "Drop Downs", priority: 4
  permit_params :name
  remove_filter :contact_us_inquiries

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Issue Type' do
      f.input :name
    end
    f.actions
  end
end