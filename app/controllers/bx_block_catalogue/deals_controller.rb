module BxBlockCatalogue
  class DealsController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch
    before_action :find_deal, only: [:show, :catalogues_by_deals]

    def index
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      @deals = Deal.all.active_deals.order(created_at: :desc)
      total_count = @deals.count

      if @deals.present?
        @deals = paginate_catalogues(@deals, page_number, per_page)
      end

      render json: DealSerializer.new(@deals).serializable_hash.merge(total_count: total_count), status: :ok
    end

    def show
      render json: DealSerializer.new(@deal).serializable_hash, status: :ok
    end

    private

    def find_deal
      @deal = Deal.all.active_deals.find_by(id: params[:id])
      if @deal.nil?
        render json: {
          message: "Deal not available"
        }, status: :not_found
      end
    end

  end
end