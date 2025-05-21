module AccountBlock
  class EmailValidationMailer < ApplicationMailer

    def activation_email
      account_variables

      mailer_call(@account,"Account activation","activation_email")
    end

    def welcome_email
      account_variables

      mailer_call(@account,@message,"welcome_email")
    end

    private

    def encoded_token
      BuilderJsonWebToken.encode @account.id, 10.minutes.from_now
    end

    def account_variables
      @account = params[:account]
      @host = Rails.env.development? ? "http://localhost:3000" : ENV['FE_URL']

      @token = encoded_token
      @reset_password = @account.user_type == 'buyer' ? "#{@host}/buyer/forgotpassword?verify=#{@token}" : "#{@host}/seller/forgotpassword?verify=#{@token}"

      @url = @account.user_type == 'buyer' ? "#{@host}/buyer/otp?verify=#{@token}" : "#{@host}/seller/otp?verify=#{@token}"
      @message = @account.user_type == 'buyer' ? "Welcome to Byezzy – Your neighbourhood marketplace for everything you need and more!" : "Welcome to Byezzy!!"
    end

    def mailer_call(account,message,file)
      mail(
        to: account.email,
        from: "admin_notification@byezzy.com",
        subject: message
      ) do |format|
        format.html { render file }
      end
    end
  end
end
