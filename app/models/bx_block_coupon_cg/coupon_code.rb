module BxBlockCouponCg
  class CouponCode < BxBlockCouponCg::ApplicationRecord
    self.table_name = :coupon_codes

    DISCOUNT_TYPE = {
        percentage: 'percentage'
    }.freeze

    validates :title, length: { maximum: 50 }, presence: true
    validates :code, length: { maximum: 50 }, presence: true
    validates :code, :title, uniqueness: { case_sensitive: false }
    validates :discount, :valid_from, :valid_to, presence: true
    validates :discount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validate :end_date_after_start_date
    has_many :subscribe_coupons, class_name: "BxBlockCouponCg::SubscribeCoupon", dependent: :destroy
    has_many :accounts, through: :subscribe_coupons, class_name: "AccountBlock::Account"
    has_many :orders, class_name: "BxBlockShoppingCart::Order"
    # belongs_to :account, class_name: "AccountBlock::Account", optional: true

    scope :active, -> { where("valid_to >= ?", Date.today) }

    private

    def end_date_after_start_date
      return if valid_to.blank? || valid_from.blank?
      if valid_to < valid_from
        errors.add(:valid_to, "end date must be after the start date")
      end
    end

    # MAX_CART_VALUE = 100_000
    # MAX_DISCOUNT_VALUE = 100_000


#     validates :discount_type, acceptance: {
#         accept: [DISCOUNT_TYPE[:flat], DISCOUNT_TYPE[:percentage]]
#     }
#     validate :min_cart_value_not_negative
#     validate :max_cart_value_less_max_value
#     validate :discount_value

#     def min_cart_value_not_negative
#       if min_cart_value.negative?
#         errors.add(:min_cart_value, "Can't be less than zero")
#       end
#     end

#     def max_cart_value_less_max_value
#       if max_cart_value > MAX_CART_VALUE
#         errors.add(:max_cart_value, "Can't be more than #{MAX_CART_VALUE}")
#       end
#     end

#     def discount_value
#       if discount.negative? || discount > MAX_DISCOUNT_VALUE
#         errors.add(:discount, 'Discount value is out of bounds')
#       end
#     end
  end
end
