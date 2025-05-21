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

require "bx_block_analytics/handler_config"
require "bx_block_analytics/bx_block_analytics_event_name"

if File.file?(Rails.root.join("config", "analytics.yml"))
  BxBlockAnalytics::HandlerConfig.handler = Rails.application.config_for(:analytics)["analytics_event_handler"].constantize

  ActiveSupport::Notifications.subscribe BxBlockAnalytics::BX_BLOCK_ANALYTICS_EVENT_NAME do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    BxBlockAnalytics::HandlerConfig.handler.new(event).call
  end
end
