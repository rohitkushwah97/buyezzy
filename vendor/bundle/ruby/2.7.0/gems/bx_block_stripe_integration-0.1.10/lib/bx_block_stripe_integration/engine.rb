# frozen_string_literal: true

module BxBlockStripeIntegration
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockStripeIntegration

    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_stripe_integration.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockStripeIntegration::Engine => base + "/stripe_integration"
      end
    end
  end
end
