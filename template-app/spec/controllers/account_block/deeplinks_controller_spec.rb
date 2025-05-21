require 'rails_helper'

RSpec.describe AccountBlock::DeeplinksController, type: :request do
  INVALID_TOKEN_MESSAGE = "Invalid token"

  let(:intern_user) { FactoryBot.create(:intern_user) }
  let(:token) { get_token(intern_user) }
  let(:token2) { BuilderJsonWebToken.encode(intern_user.id, 2.day.from_now) }
  let(:invalid_token) { "invalidtoken123" }

  let(:dl_url) { "/account_block/deeplinks/dl" }
  let(:forgot_password_url) { "/account_block/deeplinks/forgot_password" }
  let(:contactus_url) { "/account_block/deeplinks/contactus_linking" }
  let(:email_preferences_url) { "/account_block/deeplinks/email_preferences_linking" }

  describe 'GET #dl' do
    it "returns success message and activates user when token is valid" do
      intern_user.expire_tokens << token
      intern_user.save

      get dl_url, params: { token: token }

      expect(response).to have_http_status(200)
      expect(response.body).to include("theinternAppFinalVersion://SUCCESS")
      expect(intern_user.reload.activated).to be_truthy
    end

    it "returns link expired message when token is invalid" do
      intern_user.expire_tokens << token2
      intern_user.save

      get dl_url, params: { token: token }

      expect(response).to have_http_status(200)
      expect(response.body).to include("theinternAppFinalVersion://Link_expired.")
    end
  end

  describe 'GET #forgot_password' do
    it "returns reset link when token is valid" do
      intern_user.update(token: token)

      get forgot_password_url, params: { token: token }

      expect(response).to have_http_status(200)
      expect(response.body).to include("theinternAppFinalVersion://resetLink/#{token}")
    end

    it "returns invalid token error when token is invalid" do
      intern_user.update(token: token)

      get forgot_password_url, params: { token: invalid_token }

      expect(response).to have_http_status(400)
      expect(response.body).to include(INVALID_TOKEN_MESSAGE)
    end
  end

  describe 'GET #contactus_linking' do
    it "returns contactus link when token is valid" do
      intern_user.expire_tokens << token
      intern_user.save

      get contactus_url, params: { token: token }

      expect(response).to have_http_status(200)
      expect(response.body).to include("theinternAppFinalVersion://contactusLink/#{token}")
    end

    it "returns invalid token error when contact us token is invalid" do
      intern_user.expire_tokens << token
      intern_user.save

      get contactus_url, params: { token: invalid_token }

      expect(response).to have_http_status(400)
      expect(response.body).to include(INVALID_TOKEN_MESSAGE)
    end
  end

  describe 'GET #email_preferences_linking' do
    it "returns email preferences link when token is valid" do
      intern_user.expire_tokens << token
      intern_user.save

      get email_preferences_url, params: { token: token }

      expect(response).to have_http_status(200)
      expect(response.body).to include("theinternAppFinalVersion://emailpreferencesLink/#{token}")
    end

    it "returns invalid token error when email preferences token is invalid" do
      intern_user.expire_tokens << token
      intern_user.save

      get email_preferences_url, params: { token: invalid_token }

      expect(response).to have_http_status(400)
      expect(response.body).to include(INVALID_TOKEN_MESSAGE)
    end
  end
end
