module BxBlockDashboard
  class TrendingProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :slider, :created_at, :updated_at

    attribute :sale_ad_image do |image|
      if image.sale_ad_image.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(image.sale_ad_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(image.sale_ad_image, only_path: true)
      end
    end
    attributes :catalogues do |object|
      if object.trending_product_selections.present?
        object.trending_product_selections.map do |tps|
        	BxBlockCatalogue::CatalogueSerializer.new(tps.catalogue).serializable_hash
        end
      end
    end
  end
end
