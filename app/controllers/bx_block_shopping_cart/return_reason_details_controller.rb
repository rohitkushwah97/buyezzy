module BxBlockShoppingCart
  class ReturnReasonDetailsController < ApplicationController
    before_action :set_return_reason_detail, only: [:show, :update, :destroy]

    def index
      @return_reason_details = BxBlockShoppingCart::ReturnReasonDetail.all
      @return_reason_details = @return_reason_details.where(shopping_cart_order_item_id: params[:order_item_id]) if params[:order_item_id].present?
      @return_reason_details = @return_reason_details.where(reason_type: params[:reason_type]) if params[:reason_type].present?

      render json: @return_reason_details.order(created_at: :desc), status: :ok
    end

    def show
      render json: @return_reason_detail, status: :ok
    end

    def create
      @return_reason_detail = ReturnReasonDetail.new(return_reason_detail_params)

      if @return_reason_detail.save
        render json: @return_reason_detail, status: :created
      else
        render json: @return_reason_detail.errors, status: :unprocessable_entity
      end
    end

    def update
      if @return_reason_detail.update(return_reason_detail_params)
        render json: @return_reason_detail, status: :ok
      else
        render json: @return_reason_detail.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @return_reason_detail.destroy
        render json: {message: 'return reason destroy'}, status: :ok
      end
    end

    private

    def set_return_reason_detail
      @return_reason_detail = BxBlockShoppingCart::ReturnReasonDetail.find(params[:id])
    end

    def return_reason_detail_params
      params.require(:return_reason_detail).permit(:title, :details, :shopping_cart_order_item_id, :reason_type)
    end
  end
end