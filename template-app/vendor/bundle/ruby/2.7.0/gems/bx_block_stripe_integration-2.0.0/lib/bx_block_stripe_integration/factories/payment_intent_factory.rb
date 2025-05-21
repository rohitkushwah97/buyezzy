FactoryBot.define do
  factory :payment_intent, class: BxBlockStripeIntegration::PaymentIntent do
    id { "pi_123" }
    client_secret { "pi_123_secret" }
    amount { 1000 }
    currency { "usd" }
    customer { "cus_123" }
    payable_reference { "order_123" }
  end
end
