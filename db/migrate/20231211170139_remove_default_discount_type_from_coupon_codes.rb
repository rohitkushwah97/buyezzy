class RemoveDefaultDiscountTypeFromCouponCodes < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :coupon_codes, :discount_type, from: "flat", to: 'percentage'
  	change_column :coupon_codes, :discount, :integer, default: 0
    add_reference :coupon_codes, :account, null: true
  end
end
