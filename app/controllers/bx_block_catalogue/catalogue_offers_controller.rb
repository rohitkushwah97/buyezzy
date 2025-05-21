module BxBlockCatalogue
  class CatalogueOffersController < ApplicationController
    before_action :set_catalogue
    before_action :set_catalogue_offer, only: [:show, :update]
    before_action :validate_json_web_token, only: [:create, :update]

    def show
      render json: CatalogueOfferSerializer.new(@catalogue_offer).serializable_hash, status: :ok
    end

    def create
      catalogue_offer_params = jsonapi_deserialize(params)
      @catalogue_offer = CatalogueOffer.new(catalogue_offer_params.merge(catalogue_id: @catalogue.id))

      if @catalogue_offer.save
        render json: CatalogueOfferSerializer.new(@catalogue_offer).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(@catalogue_offer.errors)}, status: :unprocessable_entity
      end
    end

    def update
      if @catalogue_offer.update(jsonapi_deserialize(params))
        render json: CatalogueOfferSerializer.new(@catalogue_offer).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@catalogue_offer.errors) }, status: :unprocessable_entity
      end
    end

    private

    def set_catalogue_offer
      @catalogue_offer = @catalogue.catalogue_offer
      if @catalogue_offer.nil? || params[:id].to_i != @catalogue_offer.id
        render json: {
          message: "Offer with id #{params[:id]} doesn't exist"
        }, status: :not_found
      end
    end

    def set_catalogue
      @catalogue = Catalogue.find_by(id: params[:catalogue_id])
      if @catalogue.nil?
        render json: {
          message: "Catalogue with id #{params[:catalogue_id]} doesn't exist"
        }, status: :not_found
      end
    end

  end
end