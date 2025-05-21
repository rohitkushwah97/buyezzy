ActiveAdmin.register BxBlockSupport::Support, as: 'Support Contacts' do
  menu parent: 'Seller Support Pages'

  permit_params :first_name, :last_name, :email, :details

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :details, as: :ckeditor
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :details do |object|
      truncate(strip_tags(object.details), length: 50)
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :details do |object|
         object.details&.html_safe
      end
      row :created_at
      row :updated_at
    end
  end

end
