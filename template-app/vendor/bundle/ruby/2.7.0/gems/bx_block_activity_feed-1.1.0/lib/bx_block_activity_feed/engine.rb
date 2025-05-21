# frozen_string_literal: true

module BxBlockActivityFeed
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockActivityFeed
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_activity_feed.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockActivityFeed::Engine => "#{base}/activity_feed"
      end
    end
  end
end
