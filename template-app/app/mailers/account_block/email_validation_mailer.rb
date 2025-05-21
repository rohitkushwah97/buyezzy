module AccountBlock
  class EmailValidationMailer < ApplicationMailer
    IMAGE_NAME = "image_.svg"
    IMAGE_PATH = "app/assets/images/image_.svg"
    def activation_email
      @account = params[:account]
      @user_name = @account.full_name
      @token = encoded_token
      attachments.inline[IMAGE_NAME] = File.read(Rails.root.join(IMAGE_PATH))

      mail(
        to: @account.email,
        from: 'kuldeepkushwah723@gmail.com',
        subject: "Account activation"
      ) do |format|
        format.html { render "activation_email" }
      end
    end

    private

    def encoded_token
      BuilderJsonWebToken.encode @account.id, 24.hours.from_now
    end
  end
end
