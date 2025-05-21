FactoryBot.define do
  factory :banner, class: "BxBlockDashboard::Banner" do
    title {'pixel'}
    description {'latest'}
    button_text {'shop now'}
    button_link {'/product_link'}
    banner_type { 'slideshow' }
    section {'header'}
    banner_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg')) }
    banner_group
  end
end
