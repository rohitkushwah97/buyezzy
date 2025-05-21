# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockStripeOrderManagement::WebhookEvent do
  subject { described_class.process_from_event(event) }

  describe ".process_from_event" do
    let!(:order) { create :order }
    let(:payable_reference) { order.id.to_s }
    let(:event_type) { "payment_intent.succeeded" }
    let(:event_payload) { JSON.parse(file_fixture("#{event_type}.json").read) }
    let(:event) do
      {
        event_id: "evt_00",
        event_type: event_type,
        object_id: "20",
        payable_reference: payable_reference,
        payload: event_payload
      }
    end

    context "when event has wrong format" do
      let(:event) do
        {wrong_attr: "deal with it"}
      end

      it "raises fetch error" do
        expect { subject }.to raise_error(KeyError, "key not found: :event_id")
      end
    end

    context "when order with given id does not exist" do
      let(:payable_reference) { "non-existing-order-id" }
      let(:error_msg) { "Couldn't find BxBlockOrderManagement::Order with 'id'=#{payable_reference}" }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound, error_msg }
    end

    context "when event_type not supported" do
      let(:event_type) { "not_supported" }
      let(:debug_msg) { "BxBlockStripeOrderManagement: Processing unsupported webhook event not_supported:evt_00" }

      before { allow(Rails.logger).to receive(:debug) }

      it "logs debug message" do
        subject
        expect(Rails.logger).to have_received(:debug).with(debug_msg)
      end
    end

    context "when event has correct format and corresponding order exists" do
      let(:expected_order_transaction_attrs) do
        {
          "order_management_order_id" => order.id,
          "account_id" => order.account_id,
          "charge_id" => "ch_000000000000000000000000",
          "amount" => 2000,
          "currency" => "USD",
          "charge_status" => "payment_intent.succeeded"
        }
      end

      it { expect { subject }.to change(BxBlockOrderManagement::OrderTransaction, :count).by(1) }
      it "order transaction has correct attributes" do
        subject
        expect(BxBlockOrderManagement::OrderTransaction.last.attributes).to include(expected_order_transaction_attrs)
      end
      it { expect { subject }.to change { order.reload.status }.to "confirmed" }
    end

    context "when payment intent has failed" do
      let(:event_type) { "payment_intent.payment_failed" }

      it { expect { subject }.to change(BxBlockOrderManagement::OrderTransaction, :count).by(1) }
      it { expect { subject }.to change { order.reload.status }.to "payment_failed" }
    end
  end
end
