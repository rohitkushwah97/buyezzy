FactoryBot.define do
  factory :shopping_cart_order, :class => 'BxBlockShoppingCart::Order' do
    customer { create :email_account }
    status { 'scheduled' }
    total_fees { 120 }
    total_items { 0 }
    total_tax { 0 }
    address { create :address }
  end
end
