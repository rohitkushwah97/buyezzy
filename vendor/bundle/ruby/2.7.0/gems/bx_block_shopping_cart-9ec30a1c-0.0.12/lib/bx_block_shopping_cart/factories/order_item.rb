FactoryBot.define do
  factory :order_item, :class => 'BxBlockShoppingCart::OrderItem' do
    order { create :shopping_cart_order }
    catalogue { create :catalogue }
    quantity { 5 }
    taxable { true }
    taxable_value { 10 }
  end
end
