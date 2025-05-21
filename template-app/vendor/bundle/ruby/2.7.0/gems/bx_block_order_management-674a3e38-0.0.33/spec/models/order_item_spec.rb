# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockOrderManagement::OrderItem, type: :model do


  let!(:account) { create :account,email: "testerd@me.com", password: "pAssword!23", password_confirmation: "pAssword!23", first_name: "test", last_name: "test", activated: true}
  let!(:category) {create :category,name: Faker::Alphanumeric.unique.alphanumeric(number: 7)}
  let!(:sub_category) {create :sub_category,name: Faker::Alphanumeric.unique.alphanumeric(number: 7)}
  let!(:catalogue) { create :catalogue,category_id: category.id, sub_category_id: sub_category.id, name: "Catalogue1", sku: "test1", stock_qty: 5 }
  let!(:catalogue_variant){create :catalogue_variant,catalogue_id: catalogue.id, price: 10}
  let!(:order) { create :order, order_number: "000001", account_id: account.id, sub_total: 30, total: 649.49, status: "created", is_gift: false, tax_charges: "0.0", is_error: false, is_group: true, is_availability_checked: false, shipping_charge: "50.0", shipping_discount: "50.0", shipping_net_amt: "0.0", shipping_total: "0.0", total_tax: "50.49", charged: true, invoiced: false, invoice_id: nil, amount: 2233, order_items_attributes: [], applied_discount: 10}
  let!(:order_item) { create :order_item,order_management_order_id: order.id, quantity: 1, catalogue_id: catalogue.id, catalogue_variant_id: catalogue_variant.id, total_price: 30}

  describe "associations" do
    it { should belong_to(:order).class_name("BxBlockOrderManagement::Order") }
    it { should belong_to(:catalogue).class_name("BxBlockCatalogue::Catalogue") }
    it { should have_many(:order_trackings).class_name("BxBlockOrderManagement::OrderTracking") }
  end

  describe "state" do
    subject { create(:order_item, status: :in_cart) }

    describe "#pending_order!" do
      it "sets state to payment_pending" do
        expect(subject).to be_in_cart
        subject.pending_order!
        expect(subject).to be_payment_pending
      end

      it "sets state to place_order" do
        expect(subject).to be_in_cart
        subject.place_order!
        expect(subject).to be_placed
      end

      it "sets state to confirm_order" do
        expect(subject).to be_in_cart
        subject.confirm_order!
        expect(subject).to be_confirmed
      end

      it "sets state to to_transit" do
        expect(subject).to be_in_cart
        subject.to_transit!
        expect(subject).to be_in_transit
      end

      it "sets state to payment_failed" do
        expect(subject).to be_in_cart
        subject.payment_failed!
        expect(subject).to be_payment_failed
      end

      it "sets state to deliver_order" do
        expect(subject).to be_in_cart
        subject.deliver_order!
        expect(subject).to be_delivered
      end

      it "sets state to cancel_order" do
        expect(subject).to be_in_cart
        subject.cancel_order!
        expect(subject).to be_cancelled
      end

      it "sets state to refund_order" do
        expect(subject).to be_in_cart
        subject.refund_order!
        expect(subject).to be_refunded
      end

      it "sets state to return_order" do
        expect(subject).to be_in_cart
        subject.return_order!
        expect(subject).to be_returned
      end
    end
  end

  describe "update_product_stock" do
    it "update product stock with is order paced" do
      BxBlockOrderManagement::OrderStatus.delete_all
      order_status = BxBlockOrderManagement::OrderStatus.create!(name: "placed", status: "placed", event_name: "place_order")
      order_item.order_status_id = order_status.id
      order_item.manage_placed_status = false
      order_item.update_product_stock
      expect(order_item.manage_placed_status).to eq true
    end

    it "update product stock with is order cancelled" do
      BxBlockOrderManagement::OrderStatus.delete_all
      order_status = BxBlockOrderManagement::OrderStatus.create!(name: "cancelled", status: "cancelled", event_name: "cancel_order")
      order_item.order_status_id = order_status.id
      order_item.manage_cancelled_status = false
      order_item.update_product_stock
      expect(order_item.manage_cancelled_status).to eq true
    end
  end

  describe "update_prices" do
    it "update price" do
      order_item.update_prices
      expect(order_item.total_price).not_to be(nil)
    end
  end
end
