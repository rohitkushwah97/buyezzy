FactoryBot.define do
  factory :seller_document, class: 'AccountBlock::SellerDocument' do
    document_type { "Trading License or Commercial Registration" }
    document_name { "MyString" }
    document_files { [] }
    vat_reason { "MyString" }
    iban { "MyString" }
    bank_address { "MyString" }
    name { "MyString" }
    bank_name { "MyString" }
    swift_code { "MyString" }
    approved { false }
    rejected {false}
    account
  end
end
