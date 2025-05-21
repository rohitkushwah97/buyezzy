ActiveAdmin.register BxBlockSupport::SocialPlatform, as: 'Social Platforms' do
  menu parent: 'Home Page'
  permit_params :social_media, :social_media_url, :social_icon

  actions :index, :show, :edit, :update

  form do |f|
    f.inputs 'Social Platform Details' do
      f.input :social_media,  as: :select, collection: ['Facebook', 'Instagram', 'LinkedIn', 'TikTok', 'YouTube'], include_blank: false
      f.input :social_media_url
      if f.object.social_icon.attached?
        f.input :social_icon, as: :file, hint: image_tag(url_for(f.object.social_icon), size: '100x100')
      else
        f.input :social_icon, as: :file
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :social_media
      row :social_media_url
      row :social_icon do |platform|
        image_tag(platform.social_icon, size: '100x100') if platform.social_icon.attached?
      end
    end
  end

  index do 
    column :social_media
    column :social_media_url
    column :social_icon do |platform|
        image_tag(platform.social_icon, size: '50x50') if platform.social_icon.attached?
      end
    actions
  end
end
