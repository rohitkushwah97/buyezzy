# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::Tracking, type: :model do
  subject { BxBlockOrderManagement::Tracking.new }
  before { subject.save }
  describe "add_tracking_number" do
    it "tracking number" do
      subject.add_tracking_number
      expect(subject.tracking_number).not_to be(nil)
    end
  end
end
