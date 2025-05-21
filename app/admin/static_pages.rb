ActiveAdmin.register BxBlockSupport::StaticPage, as: 'Footer Static Pages' do
  menu parent: 'Home Page'
  permit_params :title, :content, :status

  actions :index, :show, :edit, :update

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title, as: :select, collection: ["About us", "Testimonials", "Contact", "Privacy Policy", "Support", "Terms & Conditions", "Shipping & Returns"]
      f.input :content, as: :ckeditor
      f.input :status
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content do |static_page|
        static_page.content&.html_safe
      end
      row :status
    end
  end

  index do 
    column :title
    column :content do |static|
      truncate(strip_tags(static.content), length: 30)
    end 
    column :status
    actions
  end

end
