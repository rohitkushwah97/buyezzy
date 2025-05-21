module AccountBlock
  class DeeplinksController < ApplicationController

    before_action :validate_json_web_token, :authenticate_account

    def dl
      @message = @current_user&.expire_tokens&.last == params[:token] ? "SUCCESS" : "Link_expired."
      @current_user.update(activated: true) if @message == "SUCCESS"
    end

    def forgot_password
      @message = @current_user.token == params[:token] ? "resetLink/#{params[:token]}" : "Link_expired"
    end

    def contactus_linking
      @message = @current_user&.expire_tokens&.last == params[:token] ? "contactusLink/#{params[:token]}" : "Link_expired"
    end

    def email_preferences_linking
      @message = @current_user&.expire_tokens&.last == params[:token] ? "emailpreferencesLink/#{params[:token]}" : "Link_expired"
    end
  end
end
