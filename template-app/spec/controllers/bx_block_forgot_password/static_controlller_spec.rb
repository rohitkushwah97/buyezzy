require 'rails_helper'

RSpec.describe BxBlockForgotPassword::StaticController, type: :controller do
  TOKEN = "test_token".freeze
  HTTP_STATUS_OK = :ok
  DEEP_LINK_REDIRECT_EXAMPLE = "a deep link redirect".freeze

  shared_examples DEEP_LINK_REDIRECT_EXAMPLE do |action, template|
    it "assigns the token and renders the #{action} template" do
      get action, params: { token: TOKEN }
      expect(assigns(:token)).to eq(TOKEN)
      expect(response).to render_template(template)
      expect(response).to have_http_status(HTTP_STATUS_OK)
    end

    it "renders without a token" do
      get action
      expect(assigns(:token)).to be_nil
      expect(response).to render_template(template)
      expect(response).to have_http_status(HTTP_STATUS_OK)
    end
  end

  describe "GET #deep_link_redirect" do
    include_examples DEEP_LINK_REDIRECT_EXAMPLE, :deep_link_redirect, 'bx_block_forgot_password/static/deep_link_redirect'
  end

  describe "GET #contact_us_deeplinking" do
    include_examples DEEP_LINK_REDIRECT_EXAMPLE, :contact_us_deeplinking, 'bx_block_forgot_password/static/contact_us_deep_link_redirect'
  end

  describe "GET #email_preferences_deeplinking" do
    include_examples DEEP_LINK_REDIRECT_EXAMPLE, :email_preferences_deeplinking, 'bx_block_forgot_password/static/email_preference_deep_link_redirect'
  end
end
