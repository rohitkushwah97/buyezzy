FactoryBot.define do
  factory :recurring_subscription, class: "BxBlockSubscriptionBilling::RecurringSubscription" do
    name { Faker::Name.unique.name }
    fee { Faker::Number.positive }
    billing_date { Faker::Date.between(from: "2022-01-01", to: "2100-01-01") }
    billing_frequency { "monthly" }
  end
end
