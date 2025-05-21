module BuilderBase
  class ApplicationController < ::ApplicationController
    MSG = "You are not authorise to perform this action."
    include JSONAPI::Deserialization
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, :authenticate_account
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def authenticate_account
      account = AccountBlock::Account.find_by(id: @token.id)
      if account.present?
        account.update(last_visit_at: Time.current)
        return render json: { error: "Account is blocked. Please contact admin."}, status: :unauthorized if account.is_blacklisted
        @current_user = account
      else
        return render json: {errors: [
          {account: "Account not found."},
        ]}, status: :not_found
      end
    end

    def intern?
      return render json: { errors: MSG }, status: 401 unless @current_user.type == "InternUser"
    end

    def business?
      return render json: { errors: MSG }, status: 401 unless @current_user.type == "BusinessUser"
    end

    def not_found
      render json: {"errors" => ["Record not found"]}, status: :not_found
    end

  end
end
