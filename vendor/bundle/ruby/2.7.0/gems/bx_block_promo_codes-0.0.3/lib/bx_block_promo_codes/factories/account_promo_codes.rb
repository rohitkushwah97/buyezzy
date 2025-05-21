FactoryBot.define do
  factory :account_promo_code, class: 'BxBlockPromoCodes::AccountPromoCode' do
    account { create :email_account }
    promo_code { create :promo_code }
    redeem_count { 10 }
  end
end
