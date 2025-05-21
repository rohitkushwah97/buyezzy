module BxBlockDashboard
	class TopBrandsController < ApplicationController
		before_action :load_top_brand, only: [:show]

		def index
			@top_brands = TopBrand.all.order(sequence_no: :asc)

			render json: TopBrandSerializer.new(@top_brands)
		end

		def show
			render json: TopBrandSerializer.new(@top_brand)
		end

		private

		def load_top_brand
			@top_brand = TopBrand.find_by(id: params[:id])
		end

	end
end
