module BxBlockCatalogue
	class GatedBrandSerializer < BuilderBase::BaseSerializer
		attributes :id, :brand_id

		attributes :reseller_permit_document do |object|
			if object.reseller_permit_document.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.reseller_permit_document, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.reseller_permit_document, only_path: true)
			end
		end

		attributes :approved, :created_at, :updated_at

		attribute :brand do |object|
			if object.brand
				BrandSerializer.new(object.brand).serializable_hash
			end
		end

		attributes :catalogues do |object|
			if object.brand&.catalogues
				object.brand.catalogues.map(&:serializable_hash)
			end
		end

	end
end
