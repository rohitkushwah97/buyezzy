# app/serializers/company_detail_serializer.rb

module BxBlockProfile
  class CompanyDetailSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :company_name, :website_link, :contact_number, :country_flag, :address, :company_description, :created_at, :updated_at, :update_by, :country_code, :phone_number, :business_user_id, :city_id, :industry_id, :country_id

    attribute :company_email do |object|
      object.business_user&.email
    end

    attribute :city_name do |object|
      object.city&.name
    end

    attribute :industry_name do |object|
      object.industry&.name
    end

    attribute :country_name do |object|
      object.country&.name
    end

    attribute :followers do |object|
      followers_count = BxBlockFavourites::Follow.where(follow_id: object.business_user_id).count
      followers_count
    end

    attribute :followings do |object|
      followings_count = BxBlockFavourites::Follow.where(account_id: object.business_user_id).count
      followings_count
    end

    attribute :photo do |object|
      host = ENV["BASE_URL"] || "http://localhost:3000"
      {
          photo: object.photo&.attached? ? host + Rails.application.routes.url_helpers.rails_blob_url(object.photo, only_path: true) : nil,
          thumbnail: object.respond_to?(:photo_thumbnail) && object.photo_thumbnail&.attached? ?
            host + Rails.application.routes.url_helpers.rails_blob_url(object.photo_thumbnail, only_path: true) :
            nil
        }
    end

  end
end