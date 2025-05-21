FactoryBot.define do
	factory :deal_catalogue, class: 'BxBlockCatalogue::DealCatalogue' do
		deal
		catalogue
		status { 1 }
		deal_price { "9.99" }

		trait :with_account do
			association :seller, factory: :account
		end
	end
end
