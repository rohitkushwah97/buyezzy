FactoryBot.define do
  factory :intern_user, class: AccountBlock::InternUser do
    email { Faker::Internet.unique.email }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    password { "Password@123" }
    full_phone_number { "+919879879870"}
    full_name { Faker::Name.unique.name }
  end
end