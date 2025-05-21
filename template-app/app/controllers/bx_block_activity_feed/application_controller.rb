# frozen_string_literal: true

module BxBlockActivityFeed
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render json: {"errors" => ["Record not found"]}, status: :not_found
    end

    def current_user
      @current_user = AccountBlock::Account.find(@token.id)
    rescue ActiveRecord::RecordNotFound => e
      render json: {errors: [
        {message: "Please login again."}
      ]}, status: :unprocessable_entity
    end
  end
end
