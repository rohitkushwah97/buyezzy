FactoryBot.define do
  factory :gated_brand, class: "BxBlockCatalogue::GatedBrand" do
    approved { false }
    reseller_permit_document { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'document.pdf')) }
    brand
  end
end
