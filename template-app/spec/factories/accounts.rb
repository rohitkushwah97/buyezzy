FactoryBot.define do
  factory :account, class: 'AccountBlock::Account' do
    sequence(:email) { |n| "user#{n}@precious.com" }  # Unique email generation
    password { 'Password@123' }
    activated { true }  # Assuming this attribute is required
  end
end
