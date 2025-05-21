FactoryBot.define do
  factory :wms_product_info, class: 'BxBlockOrderManagement::WmsProductInfo' do
    seller
    catalogue
    product_information_id { "1" }
    product_dimensions_info { "sku-wms" }
  end
end
