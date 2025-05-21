require "builder_base"

require "account_block"
require "builder_json_web_token"

require "bx_block_stripe_integration/engine"

require "stripe"
require "stripe_event"

module BxBlockStripeIntegration
  class Error < StandardError; end

  class PayableNotFoundError < Error; end

  class PayablePreconditionsUnmet < Error; end

  class << self
    def configure
      yield self
    end

    def api_key=(key)
      Stripe.api_key = key
    end

    def payment_intent_delegate=(delegate)
      raise Error, "#{name}.payment_intent_delegate already set" if @payment_intent_delegate

      @payment_intent_delegate = delegate
    end

    def payment_intent_delegate
      raise Error, "#{name}.payment_intent_delegate not set" unless @payment_intent_delegate

      @payment_intent_delegate
    end

    def reset_payment_intent_delegate!
      @payment_intent_delegate = nil
    end

    def signing_secret=(secret)
      StripeEvent.signing_secret = secret
    end
  end
end
