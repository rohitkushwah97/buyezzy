module AccountBlock
  class AccountActivationMailer < ApplicationMailer
    IMAGE_NAME = "image_.png"
    IMAGE_PATH = "app/assets/images/image_.png"
    def activation_email
      @token = encoded_token
      params[:account].expire_tokens << @token
      params[:account].save
      attachments.inline[IMAGE_NAME] = File.read(Rails.root.join(IMAGE_PATH))

      mail(
        to: params[:account].email,
        subject: "Account activation"
      ) do |format|
        format.html { render "activation_email" }
      end
    end

    def ban_account
      attachments.inline[IMAGE_NAME] = File.read(Rails.root.join(IMAGE_PATH))
      @otp = params[:otp]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
      mail(
          to: @otp.email,
          from: 'builder.bx_dev@engineer.ai',
          subject: 'Account Banned – Action Required') do |format|
        format.html { render 'ban_account' }
      end
    end

    def inactivity_email
      attachments.inline[IMAGE_NAME] = File.read(Rails.root.join(IMAGE_PATH))
      @otp = params[:otp]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
       mail(
        to: @otp.email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Reconnect with The Intern'
      ) do |format|
        format.html { render 'inactivity_intern_email' }
  end
    end

    private

    def encoded_token
      BuilderJsonWebToken.encode params[:account].id, 24.hours.from_now
    end
  end
end
