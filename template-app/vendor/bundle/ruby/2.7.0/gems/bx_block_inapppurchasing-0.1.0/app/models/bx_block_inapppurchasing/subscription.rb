module BxBlockInapppurchasing
  class Subscription < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_inapppurchasing_inapp_subscriptions
    validates_presence_of :transaction_id, :platform, :receipt, presence: true
  end
end

