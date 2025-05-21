module BxBlockForgotPassword
  class StaticController < ApplicationController
    skip_before_action :authenticate_account
    skip_before_action :validate_json_web_token
    def deep_link_redirect
      @token = params[:token]
      render template: 'bx_block_forgot_password/static/deep_link_redirect'
    end

    def contact_us_deeplinking
      @token = params[:token]
      render template: 'bx_block_forgot_password/static/contact_us_deep_link_redirect'
    end

    def email_preferences_deeplinking
      @token = params[:token]
      render template: 'bx_block_forgot_password/static/email_preference_deep_link_redirect'
    end
  end
end