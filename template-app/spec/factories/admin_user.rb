FactoryBot.define do
  factory :admin, class: AdminUser do
    email  { Faker::Internet.email }
    password {"ABC@123456"}
  end
end