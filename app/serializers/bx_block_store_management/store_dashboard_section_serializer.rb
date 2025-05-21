 module BxBlockStoreManagement
	class StoreDashboardSectionSerializer < BuilderBase::BaseSerializer
		attributes :id, :store_id, :section_name, :section_type, :banner_name, :banner_url, :created_at, :updated_at

		attributes :banner_image do |object|
			if object.banner_image.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.banner_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.banner_image, only_path: true)
			end
		end

		attributes :store_section_grids do |object|
			if object.store_section_grids
				object.store_section_grids.order(created_at: :asc).map do |store_section_grid|
					BxBlockStoreManagement::StoreSectionGridSerializer.new(store_section_grid).serializable_hash
				end
			end
		end

		# attribute :store do |object|
		# 	object.store.serializable_hash
		# end
	end
end
