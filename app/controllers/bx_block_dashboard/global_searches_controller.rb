module BxBlockDashboard
	class GlobalSearchesController < ApplicationController
		include BxBlockCatalogue::CatalogueSearch
		before_action :catalogues

		def search
			return render_no_product_found if params[:search_keyword].blank?

			catalogues = product_search_by_tbc(params[:search_keyword], @catalogues) || []
      catalogues = filter_out_of_stock(catalogues) if out_of_stock_filter?
			min_range, max_range = get_min_max_value(catalogues)

			catalogues = apply_category_filters(catalogues) if category_filter_present?
			catalogues = apply_price_filters(catalogues, params[:min_price], params[:max_price]) if price_filters_present? && catalogues.present?
			catalogues = filter_by_custom_field_values(catalogues, params[:custom_field_values]) if params[:custom_field_values].present?
			catalogues = filter_by_ratings(catalogues,params[:filter_by_rating]) if params[:filter_by_rating].present?
			catalogues = filter_by_colors(catalogues, params[:color_filter]) if params[:color_filter].present?

			catalogues = sort_catalogues(catalogues, params[:sort_by]) if sort_by_present?
			per_page = params[:per_page].presence || 50
			page = params[:page].presence || 1

			total_count = catalogues.count

			catalogues = paginate_catalogues(catalogues, page, per_page) if catalogues.present?

			render_search_results(catalogues, min_range, max_range, nil, total_count)
		end

		def brands_filter_lists
			return render_no_result_found if params[:search_keyword].blank? && params[:trending_slider].blank?

			catalogues = fetched_catalogues(params[:trending_slider], params[:search_keyword])

			if catalogues.present?
				brands = extract_brands_from_catalogues(catalogues)
				render json: BxBlockCatalogue::BrandSerializer.new(brands).serializable_hash, status: :ok
			else
				render_no_result_found
			end
		end

		def categories_filter_lists
			return render_no_result_found if params[:search_keyword].blank? && params[:trending_slider].blank?

			catalogues = fetched_catalogues(params[:trending_slider], params[:search_keyword])

			if catalogues.present?
				categories = extract_categories_from_catalogues(catalogues)
				render json: BxBlockCategories::CategorySerializer.new(categories).serializable_hash, status: :ok
			else
				render_no_result_found
			end
		end

		private

		def catalogues
			@catalogues = BxBlockCatalogue::Catalogue.joins(:product_content).where(status: true)
		end

		def apply_category_filters(catalogues)
			conditions = {
				category_id: params[:category_ids],
				sub_category_id: params[:sub_category_ids],
				mini_category_id: params[:mini_category_ids],
				micro_category_id: params[:micro_category_ids],
				brand_id: params[:brand_ids]
			}

			filtered_conditions = conditions.reject { |_, value| value.blank? }

			catalogues.where(filtered_conditions)
		end

		def category_filter_present?
			params[:category_ids].present? || params[:sub_category_ids].present? || params[:mini_category_ids].present? || params[:micro_category_ids].present? || params[:brand_ids].present?
		end

		def price_filters_present?
			params[:min_price].present? && params[:max_price].present?
		end

		def sort_by_present?
			params[:sort_by].present?
		end

    def filter_out_of_stock(catalogues)
      catalogues.where('COALESCE(stocks, 0) <= ?', 0)
    end

    def out_of_stock_filter?
      params[:out_of_stocks]&.to_s == 'true'
    end
		def extract_brands_from_catalogues(catalogues)
			catalogues.map(&:brand).uniq
		end

		def extract_categories_from_catalogues(catalogues)
			catalogues.map(&:category).uniq
		end

		def extract_catalogues_from_trending_slider(slider)
			trending_product = TrendingProduct.find_by(slider: slider)
			catalogue_ids = trending_product&.catalogues&.pluck(:id) || []
			BxBlockCatalogue::Catalogue.where(id: catalogue_ids)
		end

		def fetched_catalogues(trending_slider, search_keyword)
			if trending_slider.present?
				extract_catalogues_from_trending_slider(trending_slider)
			else
				product_search_by_tbc(search_keyword, @catalogues)
			end
		end

		def product_search_by_tbc(product_keyword, catalogues_scope)
			product_keyword = "%#{product_keyword&.strip&.downcase}%"
      search_columns = %w[ catalogues.product_title brands.brand_name categories.name 
                          sub_categories.name mini_categories.name micro_categories.name]
      query = search_columns.map { |col|  "LOWER(#{col}) LIKE :query"}.join(" or ")
			catalogues_scope.joins(:brand, :category, :sub_category, :mini_category, :micro_category)
                  .where(query, query: product_keyword)
		end

	end
end
