# spec/models/bx_block_coupon_cg/subscribe_coupon_spec.rb
require 'rails_helper'

RSpec.describe BxBlockCouponCg::SubscribeCoupon, type: :model do
  describe 'associations' do
    it { should belong_to(:account).class_name('AccountBlock::Account') }
    it { should belong_to(:coupon).class_name('BxBlockCouponCg::CouponCode').with_foreign_key('coupon_code_id') }
  end
end
