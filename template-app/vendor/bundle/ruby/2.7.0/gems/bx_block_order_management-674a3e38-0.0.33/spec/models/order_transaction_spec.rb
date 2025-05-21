# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::OrderTransaction, type: :model do
  subject { BxBlockOrderManagement::OrderTransaction.new }
  before { subject.save }
  describe "associations" do
    it { should belong_to(:order).class_name("BxBlockOrderManagement::Order") }
    it { should belong_to(:account).class_name("AccountBlock::Account") }
  end
end
