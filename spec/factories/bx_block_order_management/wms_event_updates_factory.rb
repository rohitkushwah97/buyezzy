FactoryBot.define do
  factory :wms_event_update do
    warehouse_code { "MyString" }
    seller_email { "MyString" }
    consignment_type { "MyString" }
    shipment_number { "MyString" }
    po_number { "MyString" }
    old_state { "MyString" }
    new_state { "MyString" }
    event_on { "2024-11-05 12:05:10" }
    time_zone { "MyString" }
    products { "" }
  end
end
