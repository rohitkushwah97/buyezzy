module BxBlockForgotPassword
  class ResetPasswordsController < ApplicationController
    skip_before_action :authenticate_account, only: [:create, :update]
    skip_before_action :validate_json_web_token, only: [:create, :update]
    before_action :validate_token, only: [:update]

    def create
      @user = AccountBlock::Account.find_by(email: params[:email].downcase)
      if @user
        BxBlockForgotPassword::ResetPasswordMailer.with(account: @user).reset_password.deliver_now!
        return render json: { message: "An email has been sent for reset password, please check!"},status: 200
      else
        return render json: { error: { message: "Account not Found" }},status: 404
      end
    end

    def update
      password = reset_params[:password]
      unless password.present?
        return render json: { error: { message: "password can't be blank, please add a valid password"} },status: :unprocessable_entity
      end
      token = request.headers[:token] || params[:token]
      @user = AccountBlock::Account.find_by(token: token)
      if @user.authenticate(password)
        return render json: { error: { message: 'New password cannot be the same as the existing password' } }, status: :unprocessable_entity
      end
      if @user.update(password: password)
        return render json: { message: "password updated successfully!" },status: 200
      else
        return render json: { error: { message: @user.errors.messages }},status: :unprocessable_entity
      end
    end

    private

    def validate_token
      @token = request.headers[:token] || params[:token]
      if @token
        account = AccountBlock::Account.find_by(token: @token)
        unless account.present?
          return render json: { errors: {message: 'Token has Expired'} },
            status: :unauthorized
        end
      else
        return render json: { errors: {message: 'please pass a valid Token'} },
            status: :unauthorized
      end
    end

    def reset_params
      params.require(:reset_password).permit(:password)
    end
  end
end