module AccountBlock
  class UnifonicOtpService
    include HTTParty
    base_uri 'https://el.cloud.unifonic.com/rest'

    def initialize(phone_number, code)
      @phone_number = phone_number
      @code = code
      @app_sid = ENV['UNIFONIC_APP_SID'] # store in credentials or .env
    end

    def send_otp
      self.class.post('/Sms/Send', body: {
        AppSid: @app_sid,
        Recipient: @phone_number,
        Body: "Your OTP code is: #{@code}"
      })
    end
  end
end
