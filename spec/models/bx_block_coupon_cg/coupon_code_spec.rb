require 'rails_helper'

RSpec.describe BxBlockCouponCg::CouponCode, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(50) }
    it { should validate_uniqueness_of(:title).case_insensitive }

    it { should validate_presence_of(:code) }
    it { should validate_length_of(:code).is_at_most(50) }
    it { should validate_uniqueness_of(:code).case_insensitive }

    it { should validate_presence_of(:discount) }
    it { should validate_numericality_of(:discount).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:valid_from) }
    it { should validate_presence_of(:valid_to) }

    it 'validates that end date is after the start date' do
      coupon = build(:coupon, valid_from: Date.today, valid_to: Date.yesterday)
      coupon.valid?
      expect(coupon.errors[:valid_to]).to include('end date must be after the start date')
    end
  end

  describe 'should have has_many association' do
    it { should have_many(:accounts).through(:subscribe_coupons).class_name('AccountBlock::Account') }
    it { should have_many(:subscribe_coupons).class_name('BxBlockCouponCg::SubscribeCoupon').dependent(:destroy) }
  end

  # describe 'should have belongs_to association' do
  #   it { should belong_to(:account).class_name('AccountBlock::Account').optional }
  # end
end