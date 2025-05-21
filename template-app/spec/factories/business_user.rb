FactoryBot.define do
  factory :business_user, class: 'AccountBlock::BusinessUser' do
    email { Faker::Internet.unique.email }
    password { 'Password@123' }
  end
end