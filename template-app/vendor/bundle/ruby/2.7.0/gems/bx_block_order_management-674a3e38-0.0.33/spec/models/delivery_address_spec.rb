# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::DeliveryAddress, type: :model do
  subject { BxBlockOrderManagement::DeliveryAddress.new }
  before { subject.save }
  describe "associations" do
  end

  describe "validation" do
    it "shold valid name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "shold valid flat_no" do
      subject.flat_no = nil
      expect(subject).to_not be_valid
    end

    it "shold valid address" do
      subject.address = nil
      expect(subject).to_not be_valid
    end

    it "shold valid zip_code" do
      subject.zip_code = nil
      expect(subject).to_not be_valid
    end

    it "shold valid flat_no" do
      subject.flat_no = nil
      expect(subject).to_not be_valid
    end
  end
end
