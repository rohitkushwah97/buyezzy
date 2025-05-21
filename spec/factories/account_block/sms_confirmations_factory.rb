FactoryBot.define do
  factory :sms_otp, class: 'AccountBlock::SmsOtp' do
    full_phone_number {"919977" + "#{rand(100000...999999)}"}
  end
end