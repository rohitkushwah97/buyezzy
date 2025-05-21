FactoryBot.define do
  factory :weekly_deal, class: "BxBlockDashboard::WeeklyDeal" do
    weekly_homiee_deal 
    caption { "MyString" }
    discount_percent { "9.99" }
    url { "https://" }
    bg_image {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Sample.jpg'))}
  end
end
