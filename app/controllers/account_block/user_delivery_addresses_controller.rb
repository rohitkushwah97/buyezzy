module AccountBlock
  class UserDeliveryAddressesController < ApplicationController
    before_action :set_user_delivery_address, only: [:show, :update, :destroy]
    before_action :find_account, only: [:create]

    def index
      @user_delivery_addresses = UserDeliveryAddress.all.where(account_id: params[:account_id]).order(created_at: :desc)

      render json: UserDeliveryAddressSerializer.new(@user_delivery_addresses).serializable_hash, status: :ok
    end

    def show
      render json: UserDeliveryAddressSerializer.new(@user_delivery_address).serializable_hash, status: :ok
    end

    def create
      @user_delivery_address = @account.user_delivery_addresses.new(user_delivery_address_params)

      if @user_delivery_address.save
        render json: UserDeliveryAddressSerializer.new(@user_delivery_address).serializable_hash, status: :created
      else
        render json: {
          errors: format_activerecord_errors(@user_delivery_address.errors)
        }, status: :unprocessable_entity
      end
    end

    def update
      if @user_delivery_address.update(user_delivery_address_params)
        render json: UserDeliveryAddressSerializer.new(@user_delivery_address).serializable_hash, status: :ok
      else
        render json: {
          errors: format_activerecord_errors(@user_delivery_address.errors)
        }, status: :unprocessable_entity
      end
    end

    def destroy
      if @user_delivery_address.destroy
        render json:{ meta: { message: "Delivery Address Removed"}}
      end
    end

    private

    def set_user_delivery_address
      @user_delivery_address = UserDeliveryAddress.find(params[:id])
    end

    def find_account
      @account = Account.find_by(id: params[:account_id])
    end

    def user_delivery_address_params
      jsonapi_deserialize(params)
    end
  end
end