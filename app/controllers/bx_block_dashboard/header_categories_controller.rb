module BxBlockDashboard
	class HeaderCategoriesController < ApplicationController
		before_action :load_header_category, only: [:show]

		def index
			@header_categories = HeaderCategory.all.order(sequence_no: :asc)

			render json: HeaderCategorySerializer.new(@header_categories)
		end

		def show
			render json: HeaderCategorySerializer.new(@header_category)
		end

		private

		def load_header_category
			@header_category = HeaderCategory.find_by(id: params[:id])
		end

	end
end
