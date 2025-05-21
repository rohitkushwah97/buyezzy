module BxBlockCatalogue
	class BrandSerializer < BuilderBase::BaseSerializer
		include FastJsonapi::ObjectSerializer
		attributes :id, :brand_name,:brand_name_arabic,:brand_website,:brand_year, :account_id

		attributes :branding_tradmark_certificate do |object|
			if object.branding_tradmark_certificate.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.branding_tradmark_certificate, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.branding_tradmark_certificate, only_path: true)
			end
		end

		attribute :brand_image do |object|
			if object.brand_image.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.brand_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.brand_image, only_path: true)
			end
		end

		attributes :approve,:restricted,:gated, :created_at, :updated_at

		attributes :store do |object|
			BxBlockStoreManagement::StoreSerializer.new(object.store).serializable_hash
		end

	end
end
