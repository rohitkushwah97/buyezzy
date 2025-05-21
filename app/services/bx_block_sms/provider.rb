module BxBlockSms
  class Provider
    TWILIO = :twilio.freeze
    KARIX = :karix.freeze
    TEST = :test.freeze
    UNIFONIC = :unifonic.freeze

    SUPPORTED = [TWILIO, KARIX, TEST, UNIFONIC].freeze

    class << self
      def send_sms(to, text_content)
        provider_klass = case provider_name
                         when TWILIO
                           Providers::Twilio
                         when KARIX
                           Providers::Karix
                         when UNIFONIC
                           Providers::Unifonic
                         when TEST
                           Providers::Test
                         else
                           raise unsupported_message(provider_name)
                         end

        provider_klass.send_sms(to, text_content)
      end

      def provider_name
        UNIFONIC
      end

      def unsupported_message(provider)
        supported_prov_msg = "Supported: #{SUPPORTED.join(", ")}."
        if provider
          "Unsupported SMS provider: #{provider}. #{supported_prov_msg}"
        else
          "You must specify a SMS provider. #{supported_prov_msg}"
        end
      end
    end
  end
end
