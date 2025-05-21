module BxBlockSubscriptionBilling
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockSubscriptionBilling
    config.generators.api_only = true
    config.builder = ActiveSupport::OrderedOptions.new
    initializer "bx_block_subscription_billing.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockSubscriptionBilling::Engine => base + "/subscription_billing"
      end
    end
  end
end
