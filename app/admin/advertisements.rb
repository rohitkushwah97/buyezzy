ActiveAdmin.register BxBlockCustomAds::Advertisement, as: 'Custom Ads' do
  menu if: proc { false }
  permit_params :name, :description, :duration, :status, :start_at, :expire_at, :banner_ad

  index do
    selectable_column
    id_column
    column :name
    column :description do |object|
      truncate(strip_tags(object.description), length: 30)
    end
    column :duration
    column :start_at
    column :expire_at
    column :status
    actions
  end

  filter :name
  filter :description
  filter :status, as: :select, collection: proc { BxBlockCustomAds::Advertisement.statuses.map { |key, value| [key, BxBlockCustomAds::Advertisement.statuses[key]] } }
  filter :start_at, as: :date_range
  filter :expire_at, as: :date_range
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  form do |f|
    f.inputs 'Advertisement Details' do
      f.input :name
      f.input :duration
      f.input :start_at, as: :date_time_picker
      f.input :expire_at, as: :date_time_picker
      if f.object.banner_ad.attached?
        f.input :banner_ad, as: :file, hint: image_tag(url_for(f.object.banner_ad), size: '100x100')
      else
        f.input :banner_ad, as: :file
      end
      f.input :status, as: :select, collection: BxBlockCustomAds::Advertisement.statuses.keys
      f.input :description, as: :ckeditor
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description do |object|
        object.description&.html_safe
      end
      row :duration
      row :start_at
      row :expire_at
      row :banner_ad do |ad|
        image_tag url_for(ad.banner_ad), size: '100x100' if ad.banner_ad.attached?
      end
      row :status
    end
  end
end
