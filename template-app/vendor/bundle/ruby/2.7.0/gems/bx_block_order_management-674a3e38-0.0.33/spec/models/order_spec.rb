# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::Order, type: :model do
  let(:account) { create :email_account }
  describe "associations" do
    it { should have_many(:order_items).class_name("BxBlockOrderManagement::OrderItem") }
    it { should have_many(:catalogues).class_name("BxBlockCatalogue::Catalogue") }
    it { should have_one(:order_transaction).class_name("BxBlockOrderManagement::OrderTransaction") }
    it { should belong_to(:account).class_name("AccountBlock::Account") }

    it { should have_many(:delivery_address_orders).class_name("BxBlockOrderManagement::DeliveryAddressOrder") }
    it { should have_many(:order_trackings).class_name("BxBlockOrderManagement::OrderTracking") }
  end

  describe "state" do
    subject { create(:order, status: :in_cart) }

    describe "#pending_order!" do
      it "sets state to payment_pending" do
        expect(subject).to be_in_cart
        subject.pending_order!
        expect(subject).to be_payment_pending
      end

      it "sets state to payment_pending" do
        expect(subject.payment_pending_at).to be_nil
        subject.pending_order!
        expect(subject.payment_pending_at).to be_a(Time)
      end
    end
  end
end
