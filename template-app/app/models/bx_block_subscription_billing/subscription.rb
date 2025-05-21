module BxBlockSubscriptionBilling
  class Subscription < ApplicationRecord
    self.table_name = :subscriptions

    def self.ransackable_attributes(auth_object = nil)
      ["id", "title", "amount", "created_at", "updated_at"]
    end
  end
end
