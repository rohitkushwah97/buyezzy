module BxBlockForgotPassword
  class ForgotPasswordMailer < ApplicationMailer
    def reset_email
      @account = params[:account]
      @host = Rails.env.development? ? "http://localhost:3000" : ENV['FE_URL']

      token = params[:token]

      @url = @account.user_type == 'buyer' ? "#{@host}/buyer/forgotpassword?verify=#{token}" : "#{@host}/seller/forgotpassword?verify=#{token}"

      mail(
        to: @account.email,
        from: "admin_notification@byezzy.com",
        subject: "Reset Password"
      ) do |format|
        format.html { render "reset_password_email" }
      end
    end

  end
end
