module BxBlockCatalogue
  class DealCataloguesController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch
    before_action :set_deal
    before_action :set_deal_catalogue, only: [:show, :update, :destroy]
    before_action :validate_json_web_token, only: [:show, :index, :create, :update, :destroy]
    before_action :get_seller, only: [:index, :create, :update, :destroy]


    def index
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      @deal_catalogues = @deal.deal_catalogues.all.where(seller_id: @seller.id).where.not(status: 'expired').order(created_at: :desc)
      total_count = @deal_catalogues.count

      if @deal_catalogues.present?
        @deal_catalogues = paginate_catalogues(@deal_catalogues, page_number, per_page)
      end

      render json: DealCatalogueSerializer.new(@deal_catalogues).serializable_hash.merge(total_count: total_count), status: :ok
    end

    def show
      render json: DealCatalogueSerializer.new(@deal_catalogue).serializable_hash
    end

    def create
      seller_deals_params = params.permit(seller_deals: [:catalogue_id,:deal_price,:seller_id]).require(:seller_deals)

      # if @deal.discount_type == 'flat'
      #   seller_deals_params = seller_deals_params.map { |param| param.merge(deal_price: @deal.discount_value)}
      # end

      begin
        @deal.deal_catalogues.transaction do
          @deal_catalogues = @deal.deal_catalogues.create!(seller_deals_params)
        end
        render json: DealCatalogueSerializer.new(@deal_catalogues).serializable_hash, status: :created
      rescue ActiveRecord::RecordInvalid => exception
        render json: { error: exception.message }, status: :unprocessable_entity
      end
    end

    def update
      if @deal_catalogue.update(jsonapi_deserialize(params))
        render json: DealCatalogueSerializer.new(@deal_catalogue).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@deal_catalogue.errors) }, status: :unprocessable_entity
      end
    end

    def destroy
      if @deal_catalogue.destroy
        render json: {
          message: "Deal Catalogue has been removed"
        }, status: :ok
      end
    end

    private

    def get_seller
      @seller = AccountBlock::Account.find_by(id: @token.id,user_type: 'seller')
      render json: {message: "Seller invalid"} and return unless @seller.present?
    end

    def set_deal
      @deal = Deal.find_by(id: params[:deal_id])
      if @deal.nil?
        render json: {
          message: "Deal not available"
        }, status: :not_found
      end
    end

    def set_deal_catalogue
      @deal_catalogue =  @deal.deal_catalogues.find_by(id: params[:id])
      if @deal_catalogue.nil?
        render json: {
          message: "Deal Catalogue not found"
        }, status: :not_found
      end
    end

    def deal_catalogue_params
      params.require(:data).require(:attributes).permit(:catalogue_id, :deal_price, :seller_id, :status)
    end

  end
end