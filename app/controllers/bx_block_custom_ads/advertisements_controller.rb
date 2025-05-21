module BxBlockCustomAds
  class AdvertisementsController < ApplicationController
    before_action :find_advertisement, only: [:show]
    def index
      advertisements = Advertisement&.active
      render json: {
        advertisements: advertisements,
        message: "Successfully loaded"
      }
    end

    # def create
    #   advertisement = Advertisement.new(advertisement_params)
    #   advertisement.seller_account_id =
    #       BxBlockCustomForm::SellerAccount.find_by(
    #         account_id: current_user.id
    #       ).id
    #   if advertisement.save
    #     render json: {
    #       advertisement: advertisement,
    #       message: "Successfully created"
    #     }, status: :created
    #   else
    #     render json: {
    #       errors: format_activerecord_errors(advertisement.errors)
    #     }, status: :unprocessable_entity
    #   end
    # end

    def show
      render json: {
        advertisement: @advertisement,
        message: "Successfully loaded"
      }
    end

    private

    def find_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # def advertisement_params
    #   params.require(:advertisement).permit(
    #     :name, :description, :duration, :advertisement_for, :status, :banner
    #   )
    # end
  end
end
