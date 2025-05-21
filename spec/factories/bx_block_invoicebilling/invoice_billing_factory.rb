FactoryBot.define do
  factory :invoice_billing, class: "BxBlockInvoicebilling::InvoiceBilling" do

    trait :with_account do
      association :customer, factory: :account
    end

    trait :with_shopping_cart_order do
      association :order, factory: :with_shopping_cart_order
    end

    trait :with_shopping_cart_order_item do
      association :order_item, factory: :with_shopping_cart_order_item
    end


  end
end
