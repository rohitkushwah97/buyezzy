FactoryBot.define do
	factory :advertisement, class: "BxBlockCustomAds::Advertisement" do
		name { "Advertisement Name" }
		description { "This is a description of the advertisement" }
		duration { 15 }
		status { 1 }
		start_at { Faker::Date.forward(days: 2) }
		expire_at { Faker::Date.between(from: start_at + 1, to: start_at + 30) }
		banner_ad { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Sample.jpg')) }
	end
end
