module BxBlockStripeOrderManagement
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockStripeOrderManagement
    config.generators.api_only = true

    initializer "bx_block_stripe_order_management.stripe_integration_configuration" do |app|
      BxBlockStripeIntegration.configure do |config|
        config.payment_intent_delegate = BxBlockStripeOrderManagement::PaymentIntentDelegate
      end
    end

    initializer "bx_block_stripe_order_management.event_subscriber" do |app|
      ActiveSupport::Notifications.subscribe("bx_block_stripe_integration.event_created") do |name, start, finish, id, payload|
        BxBlockStripeOrderManagement::WebhookEvent.process_from_event(payload)
      end
    end
  end
end
