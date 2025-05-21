FactoryBot.define do
  factory :create_shipment, :class => 'BxBlockFedexIntegration::CreateShipment' do
    auto_assign_drivers { false }
    requested_by { "Profile_67ff1b39-37f0-4f6c-aac7-71cf844b331a" }
    shipper_id { "Profile_67ff1b39-37f0-4f6c-aac7-71cf844b331a" }
  end
end
