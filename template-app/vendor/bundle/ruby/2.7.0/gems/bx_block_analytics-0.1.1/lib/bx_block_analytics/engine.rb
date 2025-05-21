# frozen_string_literal: true

require "rswag"

module BxBlockAnalytics
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockAnalytics
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_analytics.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockAnalytics::Engine => base + "/analytics"
      end
    end
  end
end
