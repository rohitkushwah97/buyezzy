# frozen_string_literal: true

module BxBlockProfile
  class ProfileSerializer < BuilderBase::BaseSerializer
    attributes(:id, :country, :address, :city, :postal_code, :account_id, :photo)

    attribute :photo do |object|
      Rails.application.routes.url_helpers.rails_blob_url(object.photo, only_path: true) if object.photo.attached?
    end
  end
end
