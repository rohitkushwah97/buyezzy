module BxBlockCouponCg
  class SubscribeCouponSerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :account_id,
      :coupon_code_id,
      :catalogue_id,
      :created_at,
      :updated_at
    ]
  end
end
