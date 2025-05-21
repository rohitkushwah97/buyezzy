FactoryBot.define do
  factory :banner_group, class: "BxBlockDashboard::BannerGroup" do
    initialize_with { BxBlockDashboard::BannerGroup.find_or_create_by(group_name: 'header_group_1') }
  end
end
