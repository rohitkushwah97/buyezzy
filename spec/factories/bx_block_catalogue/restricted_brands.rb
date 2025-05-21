FactoryBot.define do
  factory :restricted_brand, class: "BxBlockCatalogue::RestrictedBrand" do
    approved { false }
    reseller_permit_document { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'document.pdf')) }
    brand
    trait :with_account do
    	association :seller, factory: :account
    end
  end
end
