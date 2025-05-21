FactoryBot.define do
  factory :user, class: 'AccountBlock::Account' do
    email { Faker::Internet.email } # Updated from `free_email` to `email`
    password { 'Password@123' }
  end
end
