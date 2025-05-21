FactoryBot.define do
  factory :favourite, class: "BxBlockFavourites::Favourite" do
    favouriteable_id { FactoryBot.create(:catalogue).id }
    favouriteable_type { "BxBlockCatalogue::Catalogue" }

    trait :with_account do
      association :user, factory: :account
    end
  end
end
