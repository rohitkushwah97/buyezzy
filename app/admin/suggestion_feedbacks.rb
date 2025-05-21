ActiveAdmin.register AccountBlock::SuggestionFeedback, as: 'Suggestion Feedback' do
  permit_params :email, :first_name, :last_name, :detail_type, :detail

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :detail_type
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :detail_type
      row :detail do |object|
        object.detail&.html_safe
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :detail_type
      f.input :detail, as: :ckeditor
    end
    f.actions
  end
end
