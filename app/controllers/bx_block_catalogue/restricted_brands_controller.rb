module BxBlockCatalogue
  class RestrictedBrandsController < ApplicationController
    before_action :validate_json_web_token
    before_action :set_seller
    before_action :set_restricted_brand, only: [:show, :update, :destroy]

    def index
      @restricted_brands = @seller.restricted_brands.all
      render json: RestrictedBrandSerializer.new(@restricted_brands).serializable_hash, status: :ok
    end

    def show
      render json: RestrictedBrandSerializer.new(@restricted_brand).serializable_hash, status: :ok
    end

    def create
      @restricted_brand = RestrictedBrand.new(restricted_brand_params.merge(seller: @seller))

      if @restricted_brand.save
        render json: RestrictedBrandSerializer.new(@restricted_brand).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(@restricted_brand.errors) }, status: :unprocessable_entity
      end
    end

    def update
      if @restricted_brand.update(restricted_brand_params)
        render json: @restricted_brand, status: :ok
      else
        render json: @restricted_brand.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @restricted_brand.destroy
      head :no_content
    end

    private

    def set_restricted_brand
      @restricted_brand = RestrictedBrand.find(params[:id])
    end

    def set_seller
      @seller = AccountBlock::Account.find_by(id: @token.id,user_type: 'seller')
      render json: {message: "Seller invalid"} and return unless @seller.present?
    end

    def restricted_brand_params
      params.permit(:brand_id, :approved, :reseller_permit_document, :seller_id)
    end

  end
end