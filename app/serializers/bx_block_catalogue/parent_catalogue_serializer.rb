module BxBlockCatalogue
	class ParentCatalogueSerializer < BuilderBase::BaseSerializer
		attributes :category_id, :brand_id, :product_title, :besku, :prod_model_no, :details, :status, :sku,
                :sub_category_id, :mini_category_id, :micro_category_id

                attributes :product_image do |object|
                	if object.product_image.attached?
                		ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.product_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.product_image, only_path: true)
                	end
                end

                attributes :created_at,:updated_at

                attributes :category do |object|
                	if object.category
                		object.category.serializable_hash(only: [:id, :name])
                	end
                end

                attributes :brand do |object|
                	if object.brand
                		object.brand.serializable_hash(only: [:id, :brand_name])
                	end
                end
	end
end