require "uri"
require "net/http"

module BxBlockSms
  module Providers
    class Unifonic
      class << self
        def send_sms(full_phone_number, text_content)
          send_unifonic_api(full_phone_number, text_content)
        end

        private

        def send_unifonic_api(full_phone_number, text_content)
          url = URI.parse('https://el.cloud.unifonic.com/rest/SMS/messages')
          https = Net::HTTP.new(url.host, url.port)
          https.use_ssl = true

          request = Net::HTTP::Post.new(url.path)
          request.set_form_data(get_request_data(full_phone_number, text_content))

          response = https.request(request)
          puts response.read_body
        end

        def get_request_data(full_phone_number, text_content)
          {
            "AppSid" => ENV['UNIFONIC_APPSID'],
            "SenderID" => ENV['UNIFONIC_SENDERID'],
            "Recipient" => full_phone_number,
            "Body" => text_content,
            "async" => true
          }
        end

        # def unifonic_message_url
        #   'https://el.cloud.unifonic.com/rest/SMS/messages'
        # end

        # def unifonic_source
        #   Rails.configuration.x.sms.from
        # end
      end
    end
  end
end
