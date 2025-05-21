# frozen_string_literal: true

require "bx_block_analytics/handler_config"
require "bx_block_analytics/bx_block_analytics_event_name"

if File.file?(Rails.root.join("config", "analytics.yml"))
  BxBlockAnalytics::HandlerConfig.handler = Rails.application.config_for(:analytics)["analytics_event_handler"].constantize

  ActiveSupport::Notifications.subscribe BxBlockAnalytics::BX_BLOCK_ANALYTICS_EVENT_NAME do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    BxBlockAnalytics::HandlerConfig.handler.new(event).call
  end
end
