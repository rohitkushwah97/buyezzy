module BxBlockForgotPassword
  class PasswordsController < ApplicationController
    before_action :decode_token, only: [:reset_password, :current_password]
    
    def forgot_password
      return render json: { errors: [{ profile: 'Email id should not be blank', }], }, status: :unprocessable_entity if create_params[:email].blank?

      account = AccountBlock::Account.find_by(email: create_params[:email].downcase.strip, user_type: create_params[:user_type])
      
      return render_invalid_email if account.blank?
    
      token = BuilderJsonWebToken.encode(account.id,10.minutes.from_now)
      ForgotPasswordMailer.with(account: account, host: request.base_url,token: token).reset_email.deliver_now
      render json: { message: { forgot_password: 'ResetPassword link has been successfully sent to the mail id',}}, status: :created
    end

    def reset_password
      token = create_params[:token] || params[:token]
      if token.blank? || create_params[:new_password].blank? || create_params[:confirm_password].blank?
        return render json: {errors: [{ reset_password: 'Token, New Password, and Confirm Password are required', }],}, status: :unprocessable_entity
      end
      return render_invalid_token unless @decoded_token
      account =  AccountBlock::Account.find_by(id: @decoded_token.id)

      if @decoded_token.expiration < 10.minutes.ago || token == account.reset_token
        return render json: {
          errors: [{ token: 'Token has expired or has already been used',}],
        }, status: :unprocessable_entity
      end

      if create_params[:new_password] !=  create_params[:confirm_password]
        return render json: {
          errors: [{reset_password: 'New Password and Confirm Password do not match',}],
        }, status: :unprocessable_entity
      end

      password_validation = AccountBlock::PasswordValidation.new(create_params[:new_password])
      if password_validation.invalid?
        return render json: {
          errors: [{password: password_validation.error_message.full_messages.first}],
        }, status: :unprocessable_entity
      end

      account.password = create_params[:new_password]
      account.reset_token = token
      account.reset_token_used_at = Time.now
      if account.save(context: :update_password)
        render json: AccountBlock::AccountSerializer.new(account, meta: { message: "Password has changed successfully" }).serializable_hash, status: :ok
      else
        render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def current_password
      if params[:data][:token].blank? || params[:data][:current_password].blank?
        return render json: {
          errors: [{ reset_password: 'Token and Current Password are required', }],
        }, status: :unprocessable_entity
      end

      return render_invalid_token unless @decoded_token
      account = AccountBlock::Account.find_by(id: @decoded_token.id)
      return render json: { errors: [{token: "Token expired",}], }, status: :unprocessable_entity if account.nil? || @decoded_token.expiration < 10.minutes.ago
      if BCrypt::Password.new(account.password_digest) == params[:data][:current_password]
        render json: {
          data: true, message: "Current Password is correct"
        }, status: :ok
      else
        render json: {
          data: false, message: 'Current Password is not correct'
        }, status: :unprocessable_entity
      end
    end

    private
    
    def decode_token
      token = params[:token] || create_params[:token]
      return if token.blank?

      begin
        @decoded_token = BuilderJsonWebToken.decode(token)
      rescue JWT::DecodeError => e
        return render_invalid_token
      end
    end

    def render_invalid_token
      render json: {
        errors: [{ token: 'Invalid token' }]
      }, status: :bad_request
    end

    def render_invalid_email
      render json: {
        errors: [{
          profile: 'The email is not registered or Email id is not valid',
        }],
      }, status: :unprocessable_entity
    end

    def create_params
      params.require(:data)
        .permit(*[
          :user_type,
          :email,
          :full_phone_number,
          :token,
          :otp_code,
          :new_password,
          :confirm_password,
        ])
    end
  end
end
