module BxBlockStoreManagement
	class StoreMenuSerializer < BuilderBase::BaseSerializer
		attributes :id, :store_name, :title, :banner_name, :position, :product_quantity, :created_at, :updated_at

		attributes :logo do |object|
			if object.logo.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.logo, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.logo, only_path: true)
			end
		end

		attributes :cover_image do |object|
			if object.cover_image.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.cover_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.cover_image, only_path: true)
			end
		end

		attribute :store do |object|
			object.store.serializable_hash
		end

		attributes :catalogues do |object|
			if object.catalogues
				object.catalogues.map do |catalogue|
					BxBlockCatalogue::CatalogueSerializer.new(catalogue).serializable_hash
				end
			end
		end
	end
end
