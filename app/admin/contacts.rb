ActiveAdmin.register BxBlockContactUs::Contact, as: 'Contact Us' do
  menu parent: 'Contact Us'
  permit_params :title, :email, :description, :contact_type, :image, :created_at, :updated_at
  filter :contact_type
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  index do
    selectable_column
    id_column
    column :title
    column :email
    column :contact_type
    column :description do |object|
      truncate(strip_tags(object.description), length: 30)
    end
    column :image do |contact|
      if contact.image.attached?
        image_tag url_for(contact.image), height: '50'
      else
        content_tag(:span, "No image yet ")
      end
    end
    column :created_at
    column :updated_at
    actions do |contact|
      link_to 'Reply', new_admin_admin_reply_path(admin_reply: { contact_id: contact.id }), style: 'background-color: #48b1ff; padding: 5px 5px; border-radius: 3px;color:white;'
    end
  end

  show do
    attributes_table do
      row :id
      row :title
      row :email
      row :description do |object|
        object.description&.html_safe
      end
      row :contact_type
      row :image do |obj|
        if obj.image.attached?
          image_tag obj.image, width:200, height:200
        else
          content_tag(:span, " No image yet")
        end  
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :email
      f.input :contact_type, as: :select, collection: BxBlockContactUs::Contact.contact_types.keys.map { |type| [type.humanize, type] }
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: '100x100') : content_tag(:span, " No image yet  ")
      f.input :description, as: :ckeditor
    end
    f.actions
  end


end