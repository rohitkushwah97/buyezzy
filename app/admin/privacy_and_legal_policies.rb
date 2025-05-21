ActiveAdmin.register BxBlockTermsandconditions::PrivacyAndLegalPolicy , as: 'Tax And Legal Policy' do
  menu label: 'Seller Tax & legal policy'
  permit_params :title, :content, :status
  
  actions :index, :show, :edit, :update

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title, as: :select, collection: ['Tax Policy', 'Legal Policy'], include_blank: false
      f.input :content, as: :ckeditor
      f.input :status
    end
    f.actions
  end

  index do
    column :title
    column :content do |page_content|
      truncate(strip_tags(page_content.content), length: 50)
    end
    column :status
    actions
  end

  show do
    attributes_table do
      row :title
      row :content do |page_content|
        page_content.content&.html_safe
      end
      row :status
    end
  end

end
