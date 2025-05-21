FactoryBot.define do
  factory :warehouse, class: 'BxBlockCatalogue::Warehouse' do
    warehouse_type { "MyString" }
    warehouse_name { "MyString" }
    warehouse_address_1 { "MyString" }
    warehouse_address_2 { "MyString" }
    contact_number { 9087654321 }
    contact_person { "MyString" }
    processing_days { 3 }
    account
  end
end
