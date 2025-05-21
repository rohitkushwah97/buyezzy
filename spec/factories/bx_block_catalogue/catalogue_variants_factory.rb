FactoryBot.define do
  factory :catalogue_variant ,class: 'BxBlockCatalogue::CatalogueVariant' do
    group_name { Faker::Lorem.word }
    micro_category
    trait :with_account do
    	association :seller, factory: :account
    end
  end
end
