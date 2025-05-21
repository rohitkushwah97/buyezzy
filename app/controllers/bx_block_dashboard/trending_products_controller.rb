module BxBlockDashboard
	class TrendingProductsController < ApplicationController
		include BxBlockCatalogue::CatalogueSearch

		before_action :load_trending_product, only: [:show]

		def index
			if params[:slider].present?
				@trending_products = TrendingProduct.where(slider: params[:slider])
			else
				@trending_products = TrendingProduct.all
			end

			render json: TrendingProductSerializer.new(@trending_products)
		end

		def show
			render json: TrendingProductSerializer.new(@trending_product)
		end

		def list_trending_products

			return render json: { message: "missing slider in params" }, status: :unprocessable_entity if params[:slider].blank?

			@trending_product = TrendingProduct.find_by(slider: params[:slider])

			if @trending_product.nil?
				return render json: { message: "No trending products found for the given slider" }, status: :not_found
			end

			catalogue_ids = @trending_product.catalogues.pluck(:id)
			catalogues = BxBlockCatalogue::Catalogue.where(id: catalogue_ids)

			if params[:out_of_stocks]&.to_s == 'true'
				catalogues = catalogues.where('COALESCE(stocks, 0) <= ?', 0)
			end

			min_range, max_range = get_min_max_value(catalogues)

			apply_category_filters(catalogues)

			if params[:custom_field_values].present?
				catalogues = filter_by_custom_field_values(catalogues, params[:custom_field_values])
			end

			if params[:filter_by_rating].present?
				catalogues = filter_by_ratings(catalogues,params[:filter_by_rating])
			end

			if params[:min_price].present? && params[:max_price].present?
				catalogues = apply_price_filters(catalogues, params[:min_price], params[:max_price])
			end

			if params[:color_filter].present?
				catalogues = filter_by_colors(catalogues, params[:color_filter])
			end

			per_page = params[:per_page].presence || 50
			page = params[:page].presence || 1

			if params[:sort_by].present?
				catalogues = sort_catalogues(catalogues, params[:sort_by])
			end

			total_count = catalogues.count

			catalogues = paginate_catalogues(catalogues, page, per_page)


			render_results(@trending_product, catalogues, min_range, max_range, total_count)
		end

		def render_results(trending_product, catalogues, min_range, max_range, total_count = 0)
			render json: BxBlockCatalogue::CatalogueSerializer.new(catalogues).serializable_hash.merge({ trending_product: trending_product, min_range: min_range,
				max_range: max_range,
				total_count: total_count} ), status: :ok
		end

		private

		def load_trending_product
			@trending_product = TrendingProduct.find_by(id: params[:id])
		end

	end
end
