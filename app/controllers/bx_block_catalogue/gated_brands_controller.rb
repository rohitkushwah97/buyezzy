module BxBlockCatalogue
  class GatedBrandsController < ApplicationController
    before_action :set_gated_brand, only: [:show, :update, :destroy]
    before_action :validate_json_web_token, only: [:create]

    def index
      @gated_brands = GatedBrand.all
      render json: GatedBrandSerializer.new(@gated_brands).serializable_hash, status: :ok
    end

    def show
      render json: GatedBrandSerializer.new(@gated_brand).serializable_hash, status: :ok
    end

    def create
      @gated_brand = GatedBrand.new(gated_brand_params)

      if @gated_brand.save
        render json: GatedBrandSerializer.new(@gated_brand).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(@gated_brand.errors) }, status: :unprocessable_entity
      end
    end

     # def update
        #   if @gated_brand.update(gated_brand_params)
        #     render json: @gated_brand
        #   else
        #     render json: @gated_brand.errors, status: :unprocessable_entity
        #   end
        # end

        # def destroy
        #   @gated_brand.destroy
        #   head :no_content
        # end

    private

    def set_gated_brand
      @gated_brand = GatedBrand.find(params[:id])
    end
        
    def gated_brand_params
      params.permit(:brand_id, :approved, :reseller_permit_document)
    end

  end
end