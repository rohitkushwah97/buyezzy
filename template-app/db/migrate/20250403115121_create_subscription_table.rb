class CreateSubscriptionTable < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.integer :amount
      t.timestamps
    end
  end
end
