module BxBlockDashboard
  class BannerSerializer < BuilderBase::BaseSerializer
    attributes :id, :title, :description, :button_text, :button_link, :banner_type, :banner_group_id, :section

    attributes :banner_image do |object|
      if object.banner_image.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.banner_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.banner_image, only_path: true)
      end
    end

    attributes :banner_group do |object|
      if object.banner_group
        object.banner_group.serializable_hash
      end
    end

    attributes :catalogue do |object|
      if object.catalogue.present?
        BxBlockCatalogue::CatalogueSerializer.new(object.catalogue).serializable_hash
      end
    end

    attributes :category do |object|
      if object.category.present?
        BxBlockCategories::CategorySerializer.new(object.category).serializable_hash
      end
    end

    attributes :sub_category do |object|
      if object.sub_category.present?
        BxBlockCategories::SubCategorySerializer.new(object.sub_category).serializable_hash
      end
    end

    attributes :deal do |object|
      if object.deal.present?
        BxBlockCatalogue::DealSerializer.new(object.deal).serializable_hash
      end
    end
  end
end
