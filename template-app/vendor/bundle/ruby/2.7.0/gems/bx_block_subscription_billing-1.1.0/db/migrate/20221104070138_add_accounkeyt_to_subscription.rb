# Protected File
class AddAccounkeytToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_reference :recurring_subscriptions, :account, foreign_key: true
  end
end
