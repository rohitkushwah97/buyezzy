FactoryBot.define do
  factory :catalogue_offer, class: 'BxBlockCatalogue::CatalogueOffer' do
    price_info { "9.99" }
    sale_price { "9.99" }
    barcode_id { "" }
    bar_code_info { "MyString" }
    sale_schedule_from { Date.today }
    sale_schedule_to { Date.today }
    warranty { "MyString" }
    comments { "MyString" }
    status { false }
    catalogue
    barcode
  end
end
