module BxBlockCouponCg
  class SubscribeCouponsController < ApplicationController
    before_action :validate_json_web_token
    before_action :check_seller_account, only: %i[create update destroy index]
    before_action :get_subscribe_coupon, only: %i[update destroy]

    def index
      serializer = SubscribeCouponSerializer.new(@account.subscribe_coupons)
      render json: serializer, status: :ok
    end

    def create
      subscribe_coupon = SubscribeCoupon.new(subscribe_coupons_params.merge(account_id: @account.id))
      if subscribe_coupon.save 
        render json: SubscribeCouponSerializer.new(subscribe_coupon).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(subscribe_coupon.errors) },status: :unprocessable_entity
      end
    end

    def update
      if @subscribe_coupon.update(subscribe_coupons_params)
        render json: SubscribeCouponSerializer.new(@subscribe_coupon).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@subscribe_coupon.errors) }, status: :unprocessable_entity
      end
    end

    def destroy
      if @subscribe_coupon.destroy
        render json: { message: 'Successfully deleted the SubscribeCoupon' }, status: :ok
      else
        render json: { errors: format_activerecord_errors(@subscribe_coupon.errors) }, status: :unprocessable_entity
      end
    end


    private

    def subscribe_coupons_params
      params.permit(:catalogue_id, :coupon_code_id)
    end

    def get_subscribe_coupon
      @subscribe_coupon = SubscribeCoupon.find_by(id: params[:id])
      if @subscribe_coupon.nil?
        render json: {
          message: "Subscribe coupon with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

    def check_seller_account
      @account = AccountBlock::Account.find_by(id: @token.id)
      if @account&.user_type == 'buyer'
        return render json: {message: 'You are not authorized to access this action'}
      end
    end
  end
end

