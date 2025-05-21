# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::OrderStatus, type: :model do
  subject { BxBlockOrderManagement::OrderStatus.new }
  before { subject.save }
  describe "associations" do
    it { should have_many(:orders).class_name("BxBlockOrderManagement::Order") }
    it { should have_many(:order_items).class_name("BxBlockOrderManagement::OrderItem") }
  end

end
