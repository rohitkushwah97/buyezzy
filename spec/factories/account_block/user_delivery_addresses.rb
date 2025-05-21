FactoryBot.define do
  factory :user_delivery_address, class: "AccountBlock::UserDeliveryAddress" do
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number {"9190 + #{rand(100000...999999)}"}
    address_1 { "MyString" }
    address_2 { "MyString" }
    city { "MyString" }
    zip_code { "MyString" }
    is_default { false }
    address_type { "MyString" }
    state { "MyString" }
    account
  end
end
