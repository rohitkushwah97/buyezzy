# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockStripeOrderManagement::PaymentIntentDelegate do
  let(:total) { 10.0 }
  let!(:order) { create :order, total: total }
  let(:payable_reference) { order.id }

  describe ".create" do
    it "creates a new instance" do
      expect(described_class.create(payable_reference)).to be_a(described_class)
    end
  end

  describe "#amount_in_cents" do
    subject { described_class.new(payable_reference).amount_in_cents }

    context "when order exists" do
      let(:amount_in_cents) { 1000 }

      it { is_expected.to eq(amount_in_cents) }
    end

    context "when order does not exist" do
      let(:payable_reference) { "non-existing-order-id" }
      let(:error_msg) { "Couldn't find BxBlockOrderManagement::Order with 'id'=#{payable_reference}" }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound, error_msg }
    end
  end

  describe "#currency" do
    subject { described_class.new(payable_reference).currency }
    let!(:order_item) { create :order_item, order: order }

    context "when order exists" do
      it { is_expected.to eq(order_item.catalogue.brand.currency) }
    end

    context "when order does not exist" do
      let(:payable_reference) { "non-existing-order-id" }
      let(:error_msg) { "Couldn't find BxBlockOrderManagement::Order with 'id'=#{payable_reference}" }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound, error_msg }
    end

    context "when order items have different currencies" do
      let(:catalogue) { create :catalogue, brand: create(:brand, currency: "GBP") }
      let!(:order_item_with_another_currency) { create :order_item, order: order, catalogue: catalogue }
      let(:error_msg) { "Order items have different currencies: USD, GBP" }

      it { expect { subject }.to raise_error BxBlockStripeIntegration::PayablePreconditionsUnmet, error_msg }
    end
  end
end
