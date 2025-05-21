ActiveAdmin.register BxBlockDashboard::Banner, as: "Banners" do
  menu label: "Dashboard Banners"
  menu parent: 'Home Page'

  permit_params :title, :description, :button_text, :button_link, :banner_type, :banner_group_id, :section, :banner_image, :category_id, :catalogue_id, :deal_id, :sub_category_id

  filter :title
  filter :description
  filter :button_text
  filter :banner_type, as: :select, collection: proc { BxBlockDashboard::Banner.banner_types.keys }
  filter :banner_group_id, as: :select, collection: proc { BxBlockDashboard::BannerGroup.all.map { |g| [g.group_name, g.id] } }
  filter :section, as: :select, collection: proc { BxBlockDashboard::Banner.sections.keys.map { |k| [k.to_s.humanize, k] } }
  filter :category_id, as: :select, collection: proc { BxBlockCategories::Category.all.map { |c| [c.name, c.id] } }
  filter :sub_category_id, as: :select, collection: proc { BxBlockCategories::SubCategory.all.map { |sc| [sc.name, sc.id] } }
  filter :deal_id, as: :select, collection: proc { BxBlockCatalogue::Deal.all.active_deals.map { |d| [d.deal_name, d.id] } }
  filter :catalogue_id, as: :select, collection: proc { BxBlockCatalogue::Catalogue.all.includes(:product_content).map { |c| [c.product_content&.product_title , c.id] } }
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  scope :all, default: true do |banners|
    banners.where.not(banner_type: BxBlockDashboard::Banner.banner_types[:top_banner])
  end

  index do
    selectable_column
    id_column
    column :title
    column :description do |object|
      truncate(strip_tags(object.description), length: 30)
    end
    column :button_text
    column :banner_type
    column :banner_group_name do |banner|
      banner.banner_group.group_name if banner.banner_group.present?
    end
    column :section
    column :banner_image do |banner|
      image_tag(banner.banner_image, size: '100x100') if banner.banner_image.attached?
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :description do |object|
        object.description&.html_safe
      end
      row :button_text
      row :banner_type
      row :banner_group_name do |banner|
        banner.banner_group.group_name if banner.banner_group.present?
      end
      row :section
      row :banner_image do |banner|
        image_tag(banner.banner_image, size: '100x100') if banner.banner_image.attached?
      end
      row :category do |banner|
        if banner.category.present?
          link_to banner.category.name, admin_category_path(banner.category)
        end
      end
      row :sub_category do |banner|
        if banner.sub_category.present?
          link_to banner.sub_category.name, admin_sub_category_path(banner.sub_category)
        end
      end
      row :deal do |banner|
        if banner.deal.present?
          link_to banner.deal.deal_name, admin_deal_path(banner.deal)
        end
      end
      row :catalogue do |banner|
        if banner.catalogue.present?
          link_to banner.catalogue.product_content&.product_title, admin_product_path(banner.catalogue)
        end
      end
    end
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
    f.inputs 'Banner Details' do
      f.input :section, as: :select, collection: BxBlockDashboard::Banner.sections.keys
      f.input :banner_type, as: :select, collection: BxBlockDashboard::Banner.banner_types.keys, hint: "Slideshow only available for header and middle"
      f.input :banner_group_id, as: :select, collection: BxBlockDashboard::BannerGroup.all.map { |g| [g.group_name, g.id] }, hint: "Banner group is only for slideshow type, please select accordingly"
       if f.object.banner_image.attached?
        f.input :banner_image, as: :file, hint: image_tag(url_for(f.object.banner_image), size: '100x100')
      else
        f.input :banner_image, as: :file
      end
      f.input :title
      f.input :category_id, as: :select, collection: BxBlockCategories::Category.all.map { |c| [c.name, c.id] }
      f.input :sub_category_id, as: :select, collection: BxBlockCategories::SubCategory.all.map { |sc| [sc.name, sc.id] }
      f.input :deal_id, as: :select, collection: BxBlockCatalogue::Deal.all.active_deals.map { |d| [d.deal_name, d.id] }
      f.input :catalogue_id, as: :select, collection: BxBlockCatalogue::Catalogue.all.includes(:product_content).where(status: true).map { |c| [c&.product_content&.product_title , c.id] }
      f.input :button_text
      f.input :description, as: :ckeditor

    end
    f.actions
  end

end
