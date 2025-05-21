FactoryBot.define do
  factory :shipping_detail, class: 'BxBlockCatalogue::ShippingDetail' do
    shipping_length { "9.99" }
    shipping_length_unit { "Gram" }
    shipping_height { "9.99" }
    shipping_height_unit { "Centimeter" }
    shipping_width { "9.99" }
    shipping_width_unit { "Feet" }
    shipping_weight { "9.99" }
    shipping_weight_unit { "Kilogram" }
    product_content
  end
end
