# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::DeliveryAddressOrder, type: :model do
  subject { BxBlockOrderManagement::DeliveryAddressOrder.new }
  before { subject.save }
  describe "associations" do
    it { should belong_to(:order).class_name("BxBlockOrderManagement::Order") }
    it { should belong_to(:delivery_address).class_name("BxBlockOrderManagement::DeliveryAddress") }
  end
end
