# This migration comes from bx_block_inapppurchasing (originally 20230424054920)
class CreateInappSubscription < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_inapppurchasing_inapp_subscriptions do |t|
    	t.string :transaction_id
    	t.string :platform
    	t.string :receipt
    	t.timestamps
    end
  end
end
