module BxBlockShoppingCart
  class ReturnExchangeRequestsController < ApplicationController
    before_action :get_customer, only: [:create, :index]
    before_action :set_return_exchange_request, only: [:show, :update, :destroy]

    def index
      @return_exchange_requests = @customer.return_exchange_requests.all.order(created_at: :desc)

      render json: @return_exchange_requests
    end

    def show
      render json: @return_exchange_request
    end

    def create
      order = Order.includes(:order_status).where('order_statuses.status': 'delivered').find_by(order_number: return_exchange_request_params[:order_number])
      return render json: { error: 'Order not found' }, status: :not_found unless order

      return_exchange_request = ReturnExchangeRequest.new(return_exchange_request_params)
      return_exchange_request.order = order
      return_exchange_request.customer = @customer

      ActiveRecord::Base.transaction do
        if return_exchange_request.save
          add_order_items(return_exchange_request)
          render json: return_exchange_request, status: :created
        else
          render json: return_exchange_request.errors, status: :unprocessable_entity
          raise ActiveRecord::Rollback
        end
      end
    end

    def destroy
      if @return_exchange_request.destroy
        render json: {message: 'Return exchange request destroy'}, status: :ok
      end
    end

    private

    def set_return_exchange_request
      @return_exchange_request = ReturnExchangeRequest.find(params[:id])
    end

    def return_exchange_request_params
      params.require(:return_exchange_request).permit(:order_number, :customer_id, :request_type, :request_reason, :description, :order_id, :status, :custom_status, order_item_ids: [])
    end

    def get_customer
      @customer = AccountBlock::Account.find_by(id: @token.id, user_type: 'buyer')
      render json: {errors: 'Customer is invalid'} and return unless @customer.present?
    end

    def add_order_items(return_exchange_request)
      order_status = BxBlockOrderManagement::OrderStatus.find_by(status: 'return')
      order_items = return_exchange_request.order_items

      if order_items.any?
        order_items.each { |item| item.update!(order_status: order_status)}
      end
    end
  end
end