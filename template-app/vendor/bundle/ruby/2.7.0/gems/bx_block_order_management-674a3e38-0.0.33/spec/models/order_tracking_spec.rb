# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::OrderTracking, type: :model do
  subject { BxBlockOrderManagement::OrderTracking.new }
  before { subject.save }

  describe "parent_orders" do
    it "check parent order" do
      subject.parent_type = "Order"
      expect(subject.parent_type).to eq "Order"
    end
  end
end
