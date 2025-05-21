# frozen_string_literal: true

module AccountBlock
  module Accounts
    class SendOtpsController < ApplicationController
      include BuilderJsonWebToken::JsonWebTokenValidation

      before_action :validate_json_web_token
      def create
        json_params = jsonapi_deserialize(params)
        account = Account.find_by(
          full_phone_number: json_params["full_phone_number"],
          activated: true
          )

        unless account.nil?
          return render json: {errors: [{
            account: "Account already activated"
          }]}, status: :unprocessable_entity
        end

        @sms_otp = SmsOtp.new(jsonapi_deserialize(params))
        email_acc = Account.find_by(full_phone_number: Phonelib.parse(@sms_otp.full_phone_number).sanitized, user_type: 'seller') || 
            Account.find_by(full_phone_number: Phonelib.parse(@sms_otp.full_phone_number).sanitized, user_type: 'buyer')

        if @sms_otp.save
          if email_acc
            BxBlockEmailNotifications::SendEmailNotificationService
            .with(account: email_acc, pin: @sms_otp.pin, subject: 'OTP for your Byezzy Account', file: 'signup_notification')
            .notification.deliver_now
          end
          render json: SmsOtpSerializer.new(@sms_otp, meta: {
            token: BuilderJsonWebToken.encode(@sms_otp.id)
          }).serializable_hash, status: :created
        else
          render json: {errors: format_activerecord_errors(@sms_otp.errors)},
          status: :unprocessable_entity
        end
      end

      private

      def format_activerecord_errors(errors)
        result = []
        errors.each do |attribute, error|
          attribute_name = attribute.to_s.gsub('_', ' ')
          result << "#{attribute_name.capitalize} #{error}"
        end
        result
      end
    end
  end
end
