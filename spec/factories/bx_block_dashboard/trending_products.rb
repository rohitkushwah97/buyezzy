FactoryBot.define do
  factory :trending_product, class: "BxBlockDashboard::TrendingProduct" do
       slider { BxBlockDashboard::TrendingProduct.sliders.keys.sample }
       sale_ad_image {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Sample.jpg'))}
  end
end
