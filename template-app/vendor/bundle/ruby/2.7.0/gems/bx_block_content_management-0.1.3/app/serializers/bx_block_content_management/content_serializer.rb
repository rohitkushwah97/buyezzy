module BxBlockContentManagement
  class ContentSerializer < BuilderBase::BaseSerializer
    attributes *[
      :title,
      :description,
      :status,
      :price,
      :user_type,
      :quantity,
      :publish_date,
      :created_at,
      :updated_at
    ]
    # attribute :images do |object, params|
    # 	if object.images.attached?
    #   	if Rails.env.production?
    #       object.images&.service_url
    #   	else
    #     	Rails.application.routes.url_helpers.rails_blob_url(
    #       object.images, only_path: true)
    #   	end
    # 	end
    # end

    attribute :images do |object|
      @host = Rails.env.development? ? 'http://localhost:3000' : ENV['BASE_URL']
      if object.images.attached?
        object.images.map { |image|
          {
            id: image.id,
            url: @host + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true),
            type: "images",
            filename: image.filename
          }
        }
      else
        ''
      end
    end
  end
end
