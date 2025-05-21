FactoryBot.define do
  factory :account, class: 'AccountBlock::Account' do
    sequence(:email) { |n| Faker::Internet.unique.email(name: Faker::Lorem.characters(number: 10, min_alpha: 4)) }
    full_phone_number {"919#{rand(100...999)}#{rand(100000...999999)}"}
     password { 'Password@123' }
     first_name {"my string"}
     last_name {"my string"}
  end
end