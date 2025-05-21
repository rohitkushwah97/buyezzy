# frozen_string_literal: true

module ApiHelper
  # include BuilderJsonWebToken::JsonWebTokenValidation
  def authenticated_header(request, user)
    token = BuilderJsonWebToken.encode(user.id)
    request.headers.merge!(token: token.to_s)
  end
end
