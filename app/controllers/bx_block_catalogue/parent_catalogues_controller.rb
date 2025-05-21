module BxBlockCatalogue
	class ParentCataloguesController < ApplicationController
		include BxBlockCatalogue::CatalogueSearch

		before_action :validate_json_web_token, only: [:search_parent_catalogues_by_title_or_brand_name]

		def search_parent_catalogues_by_title_or_brand_name
			per_page = params[:per_page].presence&.to_i || 10
	        page_number = params[:page].presence&.to_i || 1
			parent_product_keyword = params[:product_keyword].to_s.strip
			brand_keywords = params[:brand_keyword]&.split(',')&.map(&:strip)
			parent_catalogues = ParentCatalogue.all
			total_count = parent_catalogues.count

			if parent_product_keyword.present?
				parent_catalogues = parent_catalogues.where('LOWER(product_title) LIKE ?', "%#{parent_product_keyword.downcase}%")
				total_count = parent_catalogues.count
			end

			if brand_keywords.present?
				brand_ids = brand_ids_by_brand_name_keyword(brand_keywords)
				parent_catalogues = parent_catalogues.where(brand_id: brand_ids)
				total_count = parent_catalogues.count
			end

			@parent_catalogues = parent_catalogues.page(page_number).per(per_page)

			if @parent_catalogues.present?
				render json: ParentCatalogueSerializer.new(@parent_catalogues).serializable_hash.merge(total_count: total_count), status: :ok
			else
				render_no_product_found
			end
		end
	end
end