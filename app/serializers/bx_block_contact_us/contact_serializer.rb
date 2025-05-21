module BxBlockContactUs
  class ContactSerializer < BuilderBase::BaseSerializer
    attributes *[
        :title,
        :email,
        :description,
        :contact_type,
        :created_at,
    ]
    attributes :image do |object|
      if object.image.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
      end
    end
  end
end
