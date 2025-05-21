module BxBlockOrderManagement
  class DeliveryRequestsController  < ApplicationController
    before_action :find_seller, only: [:index, :create, :update, :destroy]
    before_action :set_delivery_request, only: [:update, :destroy, :show]
  

    def index
        @delivery_requests = @seller.delivery_requests.order(created_at: :desc)
        unless @delivery_requests.present?
          render json: {
            message: "No Delivery Request is present"
          } and return
        end
        render json: BxBlockOrderManagement::DeliveryRequestSerializer.new(
          @delivery_requests, meta: {message: "List of all delivery request"}
        ).serializable_hash
    end

    def create
      find_order(params[:data][:attributes][:order_number])
      @delivery_request = DeliveryRequest.new(delivery_request_params.merge({seller_id: @seller.id, order_id: @order&.id}))
      if @delivery_request.save
        render json: BxBlockOrderManagement::DeliveryRequestSerializer.new(@delivery_request, meta: {
          message: "Delivery Request Created Successfully"
        }).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(@delivery_request.errors)},
          status: :unprocessable_entity
      end
    end

    def update
      find_order(@delivery_request.order_number)
      if @delivery_request.update(delivery_request_params.merge({seller_id: @seller.id, order_id: @order&.id}))
        render json: BxBlockOrderManagement::DeliveryRequestSerializer.new(@delivery_request, meta: {
          message: "Delivery request Updated Successfully"
        }).serializable_hash, status: :ok
      else
        render json: {errors: format_activerecord_errors(@delivery_request.errors)},
          status: :unprocessable_entity
      end
    end

    def destroy
      if @delivery_request.destroy
        render json: {message: "Delivery request deleted succesfully!"}, status: :ok
      end
    end

    def show
      if @delivery_request.present?
         render json: BxBlockOrderManagement::DeliveryRequestSerializer.new(@delivery_request, meta: {
          message: "Delivery request fetched Successfully"
        }).serializable_hash, status: :ok
      end
    end

    private

    def delivery_request_params
      params.require(:data).require(:attributes).permit(
        :warehouse_id, :warehouse_name, :seller_id, :order_number, :address_1, :address_2, :status
      )
    end
    
    def set_delivery_request
      @delivery_request = DeliveryRequest.find_by(id: params[:id])
      if @delivery_request.nil?
        render json: {
            message: "Delivery request with id #{params[:id]} doesn't exists"
          }, status: :not_found
      end
    end

    def find_seller
      @seller = AccountBlock::Account.find_by(id: @token.id, user_type: 'seller')
      render json: {errors: 'Seller is invalid'} and return unless @seller
    end

    def find_order(order_number)
      @order = BxBlockShoppingCart::Order.find_by(order_number: order_number)
      @order
    end

   end
 end  