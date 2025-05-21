FactoryBot.define do
  factory :store, class: "BxBlockStoreManagement::Store" do
    store_name { Faker::Name.unique.name + Faker::Lorem.word }
    store_year { 1 }
    store_url { "MyString" }
    website_social_url { "MyString" }
    brand_trade_certificate {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'document.pdf'))}
    approve { true }
    brand
  end
end
