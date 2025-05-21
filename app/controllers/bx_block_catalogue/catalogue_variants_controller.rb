module BxBlockCatalogue
  class CatalogueVariantsController < ApplicationController

    before_action :validate_json_web_token
    before_action :set_seller
    before_action :set_catalogue_variant, only: [:show, :update, :destroy]

    def create
      variant = @seller.catalogue_variants.new(variants_params)

      if variant.save
        render json: CatalogueVariantSerializer.new(variant).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(variant.errors) }, status: :unprocessable_entity
      end
    end

    def index
      if params[:micro_category_id]
        @variants = @seller.catalogue_variants.where(micro_category_id: params[:micro_category_id]).order(created_at: :desc)
      else
        @variants = @seller.catalogue_variants.order(created_at: :desc)
      end
      render json: CatalogueVariantSerializer.new(@variants).serializable_hash, status: :ok
    end

    def show
      render json: CatalogueVariantSerializer.new(@catalogue_variant).serializable_hash, status: :ok
    end

    def update
      if @catalogue_variant.update(variants_params)
        render json: CatalogueVariantSerializer.new(@catalogue_variant).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@catalogue_variant.errors) }, status: :unprocessable_entity
      end
    end

    def destroy
      if @catalogue_variant.destroy
        render json: { message: "Variant group destroyed" }, status: :ok
      else
        render json: @catalogue_variant.errors, status: :unprocessable_entity
      end

    end

    private

    def set_seller
      @seller = AccountBlock::Account.find_by(id: @token&.id, user_type: 'seller')
      render json: {"error": "Seller invalid"} unless @seller
    end

    def set_catalogue_variant
      @catalogue_variant = CatalogueVariant.all.find(params[:id])
    end

    def variants_params
      params.require(:data).require(:attributes).permit(
        :group_name,
        :micro_category_id,
        variant_attributes_attributes: [
          :id,
          :attribute_name,
          :_destroy,
          attribute_options_attributes: [:id, :option, :_destroy]
        ]
        )
    end
  end
end
