module BxBlockCouponCg
  class SubscribeCoupon < BxBlockCouponCg::ApplicationRecord
    self.table_name = :subscribe_coupons
    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :coupon, class_name: "BxBlockCouponCg::CouponCode", foreign_key: :coupon_code_id
    belongs_to :catalouge, class_name: "BxBlockCatalogue::Catalogue",optional: true
  end
end
