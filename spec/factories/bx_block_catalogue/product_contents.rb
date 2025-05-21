FactoryBot.define do
  factory :product_content, class: 'BxBlockCatalogue::ProductContent' do
    gtin { Faker::Number.number(digits: 9) + Faker::Number.number(digits: 3)}
    # unique_psku { Faker::Alphanumeric.alpha(number: 8) }
    brand_name { "MyString" }
    product_title { "MyString" }
    mrp { 10.00 }
    retail_price { 11.00 }
    long_description { "MyText" }
    whats_in_the_package { "MyString" }
    country_of_origin { "India" }
    product_color {"Grey"}
    dispenser_type { "MyString" }
    scent_type { "MyString" }
    target_use { "MyString" }
    style_name { "MyString" }
    catalogue

    after(:build) do |product_content|
        product_content.feature_bullets_attributes = [{ value: "feature 1" }]
        product_content.image_urls_attributes = [{ url: "www.img.com" }]
        
      if product_content.catalogue.present?
        product_content.unique_psku = product_content.catalogue.sku
      end
    end
  end
end
