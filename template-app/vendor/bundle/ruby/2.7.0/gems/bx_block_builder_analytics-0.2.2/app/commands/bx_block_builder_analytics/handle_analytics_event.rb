# frozen_string_literal: true
# Protected Area Start
# Copyright (c) 2024 Engineer.ai Corp. (d/b/a Builder.ai). All rights reserved.
#  *
# This software and related documentation are proprietary to Builder.ai.
# This software is furnished under a license agreement and/or a nondisclosure
# agreement and may be used or copied only in accordance with the terms of such
# agreements. Unauthorized copying, distribution, or other use of this software
# or its documentation is strictly prohibited.
#  *
# This software: (1) was developed at private expense and no part of it was
# developed with government funds, (2) is a trade secret of Builder.ai for all
# purposes of the Freedom of Information Act, (3) is "commercial computer
# software" subject to limited utilization as provided in the contract between
# Builder.ai and its licensees, and (4) in all respects is proprietary data
# belonging solely to Builder.ai.
#  *
# For inquiries regarding licensing, please contact: legal@builder.ai
# Protected Area End

require "uri"
require "net/http"

module BxBlockBuilderAnalytics
  class HandleAnalyticsEvent < BxBlockAnalytics::HandleAnalyticsEvent
    attr_internal :event, :endpoint

    def initialize(event, endpoint: BuilderAnalyticsConfig.analytics_endpoint)
      @_event = event
      @_endpoint = endpoint
    end

    def call
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.request_uri)
      request.content_type = "application/json"

      body = {
        type: "analytics_event",
        data: { event: event.payload[:event_name],
                userId: event.payload[:identifier],
                properties: event.payload[:properties] }
      }
      request.body = body.to_json

      http.request(request)
    end
  end
end
