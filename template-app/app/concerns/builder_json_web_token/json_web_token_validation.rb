# frozen_string_literal: true

module BuilderJsonWebToken
  module JsonWebTokenValidation
    ERROR_CLASSES = [
      JWT::DecodeError,
      JWT::ExpiredSignature,
    ].freeze

    private

    def validate_json_web_token
      token = request.headers[:token] || params[:token]
      begin
        @token = JsonWebToken.decode(token)
        account_id = @token.id
        account = AccountBlock::Account.find_by(id: account_id)

        if account && account.invalid_tokens.include?(token)
          return render json: { errors: [token: 'Token has been revoked'] },
            status: :unauthorized
        end

      rescue *ERROR_CLASSES => exception
        handle_exception exception
      end
    end

    def handle_exception(exception)
      # order matters here
      # JWT::ExpiredSignature appears to be a subclass of JWT::DecodeError
      case exception
      when JWT::ExpiredSignature
        return render json: { errors: [token: 'Token has Expired'] },
          status: :unauthorized
      when JWT::DecodeError
        return render json: { errors: [token: 'Invalid token'] },
          status: :bad_request
      end
    end
  end
end
