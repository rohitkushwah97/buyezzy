module BxBlockCouponCg
  class CouponCodesController < ApplicationController
    before_action :validate_json_web_token
    before_action :check_seller_account, only: %i[show index]
    before_action :load_coupon, only: %i[show]


    def show
      render json: CouponCodeSerializer.new(@coupon).serializable_hash, status: :ok
    end

    #GET /coupons
    def index
      render json: CouponCodeSerializer.new(CouponCode.active), status: :ok
    end

    private

    def check_seller_account
      account = AccountBlock::Account.find_by(id: @token.id)
      if account.nil? && !account&.user_type == 'seller'
        return render json: {message: 'You are not authorized to access this action'}
      end
    end

    def load_coupon
      @coupon = CouponCode.find_by(id: params[:id])
      if @coupon.nil?
        render json: {
          message: "Coupon with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end
  end
end

