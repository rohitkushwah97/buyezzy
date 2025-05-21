module BxBlockDashboard
  class HeaderCategorySerializer < BuilderBase::BaseSerializer
    attributes :id, :sequence_no, :category_id, :created_at, :updated_at

    attributes :category do |object|
    	category = object.category
    	if category
    		{
    			"id": category.id,
    			"name": category.name,
    			"created_at": category.created_at,
    			"updated_at": category.updated_at,
    			"header_image": ((ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(category.header_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(category.header_image, only_path: true)) if category.header_image.attached?),
    			"category_image": ((ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(category.category_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(category.category_image, only_path: true)) if category.category_image.attached?),
    		}
    	end
    end
  end
end