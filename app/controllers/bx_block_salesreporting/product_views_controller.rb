module BxBlockSalesreporting
  class ProductViewsController < ApplicationController
    skip_before_action :validate_json_web_token, only: [:create]
    before_action :find_user, only: [:browsing_history]

    def create
      @view = ProductView.new(product_view_params)

      if @view.save
        render json: { success: true, view: @view }, status: :created
      else
        render json: { errors: @view.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def browsing_history

      browsing_histories = ProductView
                               .includes(:catalogue)
                               .where(user: @account, catalogues: { status: true })
                               .where('viewed_at >= ?', 15.days.ago)
                               .order(viewed_at: :desc)

      browsing_histories = browsing_histories.uniq { |view| view.catalogue_id }  


      render json: BxBlockSalesreporting::ProductViewSerializer.new(browsing_histories), status: :ok
    end

    private

    def find_user
      @account = AccountBlock::Account.find_by(id: @token&.id, user_type: 'buyer')
      render json: { errors: 'Buyer is invalid' } and return unless @account
    end

    def product_view_params
      params.require(:product_view).permit(:catalogue_id, :user_id)
    end

  end
end