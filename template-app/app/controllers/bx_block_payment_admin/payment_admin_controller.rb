module BxBlockPaymentAdmin
  class PaymentAdminController < ApplicationController
    def index
     
      if params[:type] == "credit"
      @payments  = BxBlockPaymentAdmin::PaymentAdmin.where("account_id = ?", @token.id )
      end
      if params[:type] == "debit"
        @payments  = BxBlockPaymentAdmin::PaymentAdmin.where("current_user_id = ?", @token.id )
      end
      if @payments.present?
      return render json: {data: @payments} , status: :ok
      else 
        return render json: {data: @payments} , status: :unprocessable_entity
      end

    end

    def show
      @payments  = BxBlockPaymentAdmin::PaymentAdmin.find(params[:id])
      return render json: {data: @payments} , status: :ok
    end
    private 

    def permit_params
      params.permit!
    end
  end
end
