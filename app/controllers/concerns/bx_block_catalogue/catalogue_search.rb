module BxBlockCatalogue
  module CatalogueSearch
    extend ActiveSupport::Concern
    CATEGORY_QUERY = 'LOWER(name) = ?'
    def filter_catalogues(catalogues,params)
      catalogues = catalogues.where(status: params[:live_status]) if params[:live_status].present?
      catalogues = catalogues.where(content_status: params[:content_status]) if params[:content_status].present?
      if params[:fulfillment].present?
        fulfilled_type = params[:fulfillment]

        catalogues = catalogues.where(
          "fulfilled_type = :fulfilled_type OR id IN (
            SELECT DISTINCT parent_product_id FROM catalogues
            WHERE fulfilled_type = :fulfilled_type AND parent_product_id IS NOT NULL
          )",
          fulfilled_type: fulfilled_type
        )
      end
      catalogues
    end

    def product_search_by_title(product_keyword, catalogues_scope, search_by)
      #here sku added because it is needed for search catalogue by title/sku api for seller side api
      query = 'LOWER(catalogues.product_title) LIKE :query '
      query += 'OR LOWER(catalogues.sku) LIKE :query OR LOWER(product_variant_groups.product_sku) LIKE :query' if search_by == "include_sku"
      catalogues_scope.where(query, query: "%#{product_keyword.downcase}%")
    end

    def variant_product_search(product_keyword, seller, brand_id = nil)
      variant_catalogues = Catalogue
                            .includes(:variant_products, :product_variant_group)
                            .references(:variant_products, :product_variant_group)
                            .where("LOWER(product_variant_groups.product_sku) LIKE :query OR LOWER(variant_products_catalogues.sku) LIKE :query OR LOWER(variant_products_catalogues.product_title) LIKE :query", query: "%#{product_keyword.downcase}%")
                            .where(seller: seller)

      variant_catalogues = variant_catalogues.where(brand_id: brand_id) if brand_id.present?

      variant_catalogues
    end

    def brand_ids_by_brand_name_keyword(keywords)
      return [] unless keywords.present?
      brand_conditions = keywords.map { |keyword| "LOWER(brand_name) LIKE '%#{keyword.downcase}%'" }.join(' OR ')
      Brand.where(brand_conditions).pluck(:id)
    end

    def apply_category_filters(catalogues)
      catalogues.where!(category_id: params[:category_ids]) if params[:category_ids].present?
      catalogues.where!(sub_category_id: params[:sub_category_ids]) if params[:sub_category_ids].present?
      catalogues.where!(mini_category_id: params[:mini_category_ids]) if params[:mini_category_ids].present?
      catalogues.where!(micro_category_id: params[:micro_category_ids]) if params[:micro_category_ids].present?
      catalogues.where!(brand_id: params[:brand_ids]) if params[:brand_ids].present?
    end

    def apply_price_filters(catalogues, min_price, max_price)

      min_price_decimal = min_price.present? ? BigDecimal(min_price) : nil
      max_price_decimal = max_price.present? ? BigDecimal(max_price) : nil

      catalogues.where('final_price >= ? AND final_price <= ?', min_price_decimal, max_price_decimal) if min_price_decimal.present? && max_price_decimal.present?

    end

    def filter_by_colors(catalogues, color_filter)

      catalogues.joins(:product_content)
      .where('product_contents.product_color IN (?)',color_filter)

    end

    def get_min_max_value(catalogues)
      catalogues = catalogues.order("final_price DESC")
      min_range = catalogues.last&.final_price || 0
      max_range = catalogues.first&.final_price || min_range || 0
      [min_range,max_range]
    end

    def sort_catalogues(catalogues, sort_by)
      case sort_by
      when 'low_to_high'
        catalogues.low_to_high
        
      when 'high_to_low'
        catalogues.high_to_low

      when 'product_title_AZ'
        catalogues.product_title_AZ

      when 'product_title_ZA'
        catalogues.product_title_ZA

      when 'whats_new'
        catalogues.whats_new

      when 'recommended'
        catalogues.recommended

      when 'customer_rating'
        sorted_catalogues_avg_rating(catalogues)

      when 'popularity'
        catalogues.popularity

      else
        catalogues
      end
    end

    def paginate_catalogues(catalogues, page, per_page)
      catalogues.page(page).per(per_page)
    end

    def render_search_results(catalogues, min_range, max_range, category, total_count = 0)
      message = catalogues.present? ? "Successfully Loaded" : "No products found"
        render json: CatalogueSerializer.new(catalogues).serializable_hash.merge({category: category, min_range: min_range,
          max_range: max_range,
          total_count: total_count,
          message: message}), status: :ok
    end

    def find_brand(brand_name)
      BxBlockCatalogue::Brand.where('LOWER(brand_name) = ?', brand_name&.strip&.downcase).first
    end

    def find_category(category_name)
      BxBlockCategories::Category.where(CATEGORY_QUERY, category_name&.strip&.downcase).first
    end

    def find_subcategory(subcategory_name)
      BxBlockCategories::SubCategory.where(CATEGORY_QUERY, subcategory_name&.strip&.downcase).first
    end

    def find_minicategory(minicategory_name)
      BxBlockCategories::MiniCategory.where(CATEGORY_QUERY, minicategory_name&.strip&.downcase).first
    end

    def find_microcategory(microcategory_name)
      BxBlockCategories::MicroCategory.where(CATEGORY_QUERY, microcategory_name&.strip&.downcase).first
    end

    def render_no_product_found
      render json: { data: [], message: "No products found", total_count: 0 }, status: :not_found
    end

    def render_no_result_found
      render json: { message: "No result found" }, status: :not_found
    end

    #rating common methods

    def sorted_catalogues_avg_rating(catalogues)
      subquery = BxBlockCatalogue::Review.approved_reviews.select('catalogue_id, AVG(rating) AS avg_rating')
      .where(review_type: 'product')
      .group('catalogue_id')

      catalogues.joins("LEFT JOIN (#{subquery.to_sql}) AS avg_ratings ON catalogues.id = avg_ratings.catalogue_id")
      .order('avg_ratings.avg_rating DESC NULLS LAST')
    end

    def average_rating(reviews)
      return 0 if reviews.empty?
      reviews.sum(&:rating).to_f / reviews.count
    end

    def seller_rating_percentage(reviews)
      total_reviews = reviews.count
      return {} if total_reviews.zero?

      percentages = {}
      (1..5).each do |rating|
        rating_count = reviews.select {|review| review.rating.to_i == rating}.count
        percentages[rating] = ((rating_count.to_f / total_reviews.to_f) * 100).round(2)
      end
      percentages
    end

    def total_rating(reviews)
      reviews.sum(&:rating)
    end

    def filter_by_custom_field_values(catalogues, custom_field_values)
      query = []
      custom_field_values.each do |value|
        query << BxBlockCatalogue::CatalogueContent.where(value: value).where(catalogue_id: catalogues.pluck(:id)).pluck(:catalogue_id)
      end
      catalogues.where(id: query.flatten)
    end

    def filter_by_ratings(catalogues, params)
      rating_result = []
      if params.present?
        ratings = params.map(&:to_i)
        min_rating = ratings.min

        rating_result = catalogues.select do |catalogue|
          reviews = catalogue.review_and_ratings.approved_reviews.where(review_type: 'product')
          average_rating = average_rating(reviews)

          average_rating >= min_rating
        end.map(&:id)
      end
      catalogues.where(id: rating_result)
    end

    def catalogues_by_active_deals(deal_id)
      DealCatalogue.all.where(deal_id: deal_id, status: 'approved').pluck(:catalogue_id)
    end

  end
end
