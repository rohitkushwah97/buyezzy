module BxBlockSupport
  class SupportsController < ApplicationController

    def create
      support_params = jsonapi_deserialize(params)

      validator = AccountBlock::EmailValidation.new(support_params["email"])

      if !validator.valid?
        return render json: { errors: [{ account: "Email invalid" }] }, status: :unprocessable_entity
      end

      @support = Support.new(support_params)

      if @support.save
        render json: @support, status: :created
      else
        render json: @support.errors, status: :unprocessable_entity
      end
    end

  end
end
