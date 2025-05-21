module BxBlockLogin
  class LoginsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, only:[:send_login_otp]
    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account', 'email_account', 'social_account'
        account = OpenStruct.new(jsonapi_deserialize(params))
        account.type = params[:data][:type]
        account.user_type = params[:data][:user_type]

        output = AccountAdapter.new

        output.on(:account_not_found) do |account|
          render json: {
            errors: [{
              failed_login: 'The email is not register or not activated',
            }],
          }, status: :unprocessable_entity
        end

        output.on(:failed_login) do |account|
          render json: {
            errors: [{
              failed_login: 'Email or Password incorrect please try again',
            }],
          }, status: :unauthorized
        end

        output.on(:successful_login) do |account, token, refresh_token, document_status, last_visited_at, first_time_login|
          if account.profile_picture.attached?
            image_url =  ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(account.profile_picture, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(account.profile_picture, only_path: true)
          else
            image_url =  nil
          end
          
          render json: {meta: {
            token: token,
            refresh_token: refresh_token,
            id: account.id,
            full_name: account.full_name,
            email: account.email,
            full_phone_number: account.full_phone_number,
            user_type: account.user_type,
            document_status: document_status,
            last_visited_at: last_visited_at,
            first_time_login: first_time_login,
            language: account.language,
            profile_picture: image_url
          }}
        end

        output.login_account(account)
      else
        render json: {
          errors: [{
            account: 'Invalid Account Type',
          }],
        }, status: :unprocessable_entity
      end
    end

    def send_login_otp
      @sms_otp = AccountBlock::SmsOtp.new(jsonapi_deserialize(params))
      email_acc = AccountBlock::Account.find_by(full_phone_number: Phonelib.parse(@sms_otp.full_phone_number).sanitized, user_type: 'seller') || 
            AccountBlock::Account.find_by(full_phone_number: Phonelib.parse(@sms_otp.full_phone_number).sanitized, user_type: 'buyer')
      if @sms_otp.save
        if email_acc
            BxBlockEmailNotifications::SendEmailNotificationService
            .with(account: email_acc, pin: @sms_otp.pin, subject: 'OTP for your Byezzy Account', file: 'signup_notification')
            .notification.deliver_now
          end
        render json: AccountBlock::SmsOtpSerializer.new(@sms_otp, meta: {
          token: BuilderJsonWebToken.encode(@sms_otp.id)
        }).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(@sms_otp.errors)},
        status: :unprocessable_entity
      end
    end
  end
end
