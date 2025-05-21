FactoryBot.define do
  factory :store_dashboard_section, class: "BxBlockStoreManagement::StoreDashboardSection" do
    section_name { "section_1" }
    section_type { "3_grids_layout" }
    banner_name { "" }
    banner_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg')) }
    banner_url {"www.example.com"}
    store
  end
end
