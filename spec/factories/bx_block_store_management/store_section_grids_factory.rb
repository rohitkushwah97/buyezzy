FactoryBot.define do
  factory :store_section_grid, class: "BxBlockStoreManagement::StoreSectionGrid" do
    grid_name { Faker::Name.unique.name }
    grid_url { "www.example.com" }
    grid_no { "grid_1" }
    grid_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg')) }
    store_dashboard_section
  end
end
