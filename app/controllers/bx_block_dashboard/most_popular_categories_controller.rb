module BxBlockDashboard
	class MostPopularCategoriesController < ApplicationController
		before_action :load_popular_category, only: [:show]

		def index
			@popular_categories = MostPopularCategory.all.order(sequence_no: :asc)

			render json: MostPopularCategorySerializer.new(@popular_categories)
		end

		def show
			render json: MostPopularCategorySerializer.new(@popular_category)
		end

		private

		def load_popular_category
			@popular_category = MostPopularCategory.find_by(id: params[:id])
		end

	end
end
