class CreateAccountsCouponCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribe_coupons do |t|
      t.integer :account_id
      t.integer :coupon_code_id
      t.integer :catalogue_id, null: true
      t.timestamps
    end
  end
end
