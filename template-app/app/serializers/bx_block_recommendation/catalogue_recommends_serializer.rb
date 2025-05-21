# frozen_string_literal: true

module BxBlockRecommendation
  class CatalogueRecommendsSerializer < BuilderBase::BaseSerializer
    attributes :base_price, :compare_at_price, :description

    attribute :name do |object, _params|
      object&.catalogue_master&.name
    end

    attribute :is_added_in_whislist do |object, _params|
      if _params[:user].present?
        user = _params[:user]
        user.customer_wishlists.where(catalogue_id: object.id).present?
      end
    end

    attribute :main_image do |object, _params|
      if object.main_image.present?
        if Rails.env.development?
          Rails.application.routes.url_helpers.rails_blob_path(object.main_image, only_path: true)
        else
          object.main_image&.service_url&.split('?')&.first
        end
      end
    end

    attribute :other_images do |object, params|
      host = params[:host] || ''
      if object.other_images.attached?
        object.other_images.map do |image|
          {
            id: image.id,
            url: if Rails.env.development?
                   (host + Rails.application.routes.url_helpers.rails_blob_url(image,
                                                                               only_path: true))
                 else
                   image.service_url
                 end
          }
        end
      end
    end
  end
end
