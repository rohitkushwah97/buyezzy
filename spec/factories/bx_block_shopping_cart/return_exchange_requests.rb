FactoryBot.define do
  factory :return_exchange_request, class: 'BxBlockShoppingCart::ReturnExchangeRequest' do
    order_number { "0000-0000000001" }
    request_type { "MyString" }
    request_reason { "MyString" }
    description { "MyText" }
    
    trait :with_shopping_cart_order do
    	association :order, factory: :shopping_cart_order
    end
    trait :with_account do
    	association :customer, factory: :account
    end
  end
end