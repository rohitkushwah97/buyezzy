FactoryBot.define do
  factory :coupon, class: 'BxBlockCouponCg::CouponCode' do
    title { Faker::Lorem.sentence }
    code { generate(:unique_coupon_code) }
    discount { Faker::Number.between(from: 5, to: 50) }
    valid_from { Faker::Date.backward(days: 10) }
    valid_to { Faker::Date.forward(days: 10) }

  end
  sequence :unique_coupon_code do |n|
    "#{Faker::Number.unique.number(digits: 8)}_#{n}"
  end
end
