class CreateCouponsAccountsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons_accounts do |t|
    	t.belongs_to :coupon
      	t.belongs_to :account
      	t.timestamps
    end
  end
end
