FactoryBot.define do
  factory :wms_consignment_order, class: "BxBlockOrderManagement::WmsConsignmentOrder" do
    order_number { "MyString" }
    seller
    catalogue
    quantity { 1 }
    unit_price { "9.99" }
  end
end
