module BxBlockForgotPassword
  class ResetPasswordMailer < ApplicationMailer
    IMAGE_NAME = "image_.png"
    IMAGE_PATH = "app/assets/images/image_.png"
    def reset_password
      account = params[:account]
      @token = encoded_token(account.id)
      account.update(token: @token)
      attachments.inline[IMAGE_NAME] = File.read(Rails.root.join(IMAGE_PATH))
      mail(
        to: params[:account].email,
        subject: "Reset Password"
      ) do |format|
        format.html { render "reset_password" }
      end
    end

    private

    def encoded_token(id)
      BuilderJsonWebToken.encode(id, 24.hours.from_now)
    end
  end
end