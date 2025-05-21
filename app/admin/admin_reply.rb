ActiveAdmin.register BxBlockContactUs::AdminReply, as: 'Admin Reply' do
    menu parent: 'Contact Us'
    permit_params  :description, :contact_id, :image, :created_at, :updated_at

    index do
      selectable_column
      id_column
      column 'Mail ID' do |contact|
        contact.contact.email if contact.contact
      end
      column :description do |object|
        truncate(object.description, length: 30)
      end
      column :image do |contact|
        if contact.image.attached?
            image_tag url_for(contact.image), height: '50'
        else
            content_tag(:span, "No image yet ")
        end
      end
      actions
    end

    show do
        attributes_table do
            row 'Mail ID' do |contact|
              contact.contact.email if contact.contact
            end
            row :description
            row :image do |contact|
              if contact.image.attached?
                image_tag url_for(contact.image)
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
          f.input :description, as: :text, input_html: { rows: 10 }
          f.input :contact_id,  as: :hidden
          f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), height: '50') : content_tag(:span, 'No image')
        end
        f.actions
    end

    controller do
        def create
          super do |format|
            send_notification(resource) if resource.valid? && resource.persisted?
          end
        end

        private

        def send_notification(admin_reply)
          BxBlockContactUs::AdminReplyMailer.notification(admin_reply).deliver_now
        end
    end
end
