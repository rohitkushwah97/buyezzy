FactoryBot.define do
  factory :promo_code, class: 'BxBlockPromoCodes::PromoCode' do
    name { Faker::Alphanumeric.unique.alphanumeric(number: 6) }
    description { 'Test post description' }
    terms_n_condition { 'Terms' }
    discount_type { :percentage }
    redeem_limit { 10 }
    max_discount_amount { 5 }
    min_order_amount { 2 }
    from { Date.today - 10.days }
    to { Date.today + 10.days }
    status { :active }
    discount { 50.0 }
  end
end
