 module BxBlockStoreManagement
	class StoreSectionGridSerializer < BuilderBase::BaseSerializer
		attributes :id, :store_dashboard_section_id, :grid_name, :grid_no, :grid_image, :grid_url, :created_at, :updated_at

		attributes :grid_image do |object|
			if object.grid_image.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.grid_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.grid_image, only_path: true)
			end
		end
	end
end
