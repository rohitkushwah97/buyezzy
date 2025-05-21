FactoryBot.define do
  factory :store_menu, class: "BxBlockStoreManagement::StoreMenu" do
    title { "MyString" }
    # store_name { "MyString" }
    banner_name { "MyString" }
    position {Faker::Number.between(from: 1, to: 8)}
    store
  end
end
