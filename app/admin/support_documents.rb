ActiveAdmin.register BxBlockSupport::SupportDocument, as: 'Support Documents' do
  menu parent: 'Seller Support Pages'

  permit_params :page_title, :content

  actions :index, :show, :edit, :update


  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :page_title, as: :select, collection: ['Features', 'Pricing', 'Cost & Commission details',"Beginner's guide",'Fulfillment by ByEzzy','Advertise on ByEzzy','Brand store']
      f.input :content, as: :ckeditor, input_html: { value: f.object.content.presence || "No content available. Please provide content." }
    end
    f.actions
  end

  index do
    column :page_title
    column :content do |page_content|
      truncate(strip_tags(page_content.content), length: 50)
    end
    actions
  end

  show do
    attributes_table do
      row :page_title
      row :content do |page_content|
         page_content.content&.html_safe
      end
    end
  end

end
