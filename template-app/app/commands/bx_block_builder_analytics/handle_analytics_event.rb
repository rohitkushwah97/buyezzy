# frozen_string_literal: true

require "uri"
require "net/http"

module BxBlockBuilderAnalytics
  class HandleAnalyticsEvent < BxBlockAnalytics::HandleAnalyticsEvent
    attr_internal :event, :endpoint, :token

    def initialize(event, endpoint: BuilderAnalyticsConfig.analytics_endpoint, token: BuilderAnalyticsConfig.analytics_auth_token)
      @_event = event
      @_endpoint = endpoint
      @_token = token
    end

    def call
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.content_type = "application/json"
      request["Authorization"] = "Basic #{token}"

      body = {
        event: event.payload[:event_name],
        userId: event.payload[:identifier],
        properties: event.payload[:properties]
      }
      request.body = body.to_json

      http.request(request)
    end
  end
end
