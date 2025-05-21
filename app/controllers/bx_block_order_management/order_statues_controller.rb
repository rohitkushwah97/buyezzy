# frozen_string_literal: true

module BxBlockOrderManagement
  class OrderStatuesController < ApplicationController
    before_action :set_order_status, only: [:show]

    def index
      render json: OrderStatusSerializer.new(OrderStatus.all).serializable_hash, status: :ok
    end

    def show
      render json: OrderStatusSerializer.new(@order_status).serializable_hash, status: :ok
    end

    private

    def set_order_status
      @order_status = OrderStatus.find_by(id: params[:id])
      if @order_status.nil?
        render json: {
            message: "Order status with id #{params[:id]} doesn't exists"
          }, status: :not_found
      end
    end
  end
end
