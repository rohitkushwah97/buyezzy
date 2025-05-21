module BxBlockShoppingCart
  class ShippedOrderDetailsController < ApplicationController
    before_action :find_order, only: [:create]
    before_action :set_shipped_order_detail, only: [:show, :update, :destroy]

    def show
      render json: @shipped_order_detail
    end

    def create
      permitted_params = shipped_order_detail_params
      order_item_ids = Array(permitted_params[:order_item_id])

      last_created_record = nil

      order_item_ids.each do |item_id|
        shipped_order_detail = ShippedOrderDetail.new(
          permitted_params.except(:order_item_id).merge(
            order_item_id: item_id,
            order_id: @order.id
          )
        )
        if shipped_order_detail.save
          last_created_record = shipped_order_detail
        else
          return render json: { errors: shipped_order_detail.errors, failed_id: item_id }, status: :unprocessable_entity
        end
      end

      render json: last_created_record, status: :created
    end

    def update
      if @shipped_order_detail.update(shipped_order_detail_params)
        render json: @shipped_order_detail, status: :ok
      else
        render json: @shipped_order_detail.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @shipped_order_detail.destroy
        render json: {message: "shipped order detail destroyed"}, status: :ok
      end
    end

    private

    def set_shipped_order_detail
      @shipped_order_detail = ShippedOrderDetail.find(params[:id])
    end

    def find_order
      @order = Order.find(params[:order_id])
    end

    def shipped_order_detail_params
      params.require(:shipped_order_detail).permit(:shipping_details, :courier_name, :tracking_number, order_item_id: [])
    end
  end
end