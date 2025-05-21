require 'rails_helper'

RSpec.describe BxBlockShoppingCart::OrderItem, type: :model do
  describe '#calculate_final_price' do
    let(:catalogue) { create(:catalogue) }
    let(:product_content) { create(:product_content, catalogue: catalogue, retail_price: 100.0) }
    let(:order_item) { create(:shopping_cart_order_item, catalogue: catalogue, quantity: 2) }
    let(:customer) { create(:account, user_type: 'buyer') }
    let(:order) { create(:shopping_cart_order, customer: customer) }

    before do
      allow(subject).to receive(:order).and_return(order)
    end

    context 'when total discount is 0' do
      it 'calculates final price without discount' do
        allow(subject).to receive(:calculate_total_discount).and_return(0.0)
        allow(subject).to receive(:calculate_total_price).and_return(100.0)
        allow(subject).to receive(:calculate_total_tax).and_return(10.0)

        result = subject.calculate_final_price

        expect(result).to eq(110.0)
      end
    end
  end

  describe '#calculate_final_discount_price' do
    it 'calculates final discount price based on order items' do
      order_item1 = instance_double(BxBlockShoppingCart::OrderItem, discount_price: 10.0, price: 20.0, quantity: 2)
      order_item2 = instance_double(BxBlockShoppingCart::OrderItem, discount_price: 0.0, price: 15.0, quantity: 3)

      allow(subject).to receive(:order).and_return(
        instance_double(BxBlockShoppingCart::Order, order_items: [order_item1, order_item2])
      )

      result = subject.calculate_final_discount_price

      expect(result).to eq(65.0)
    end
  end

  describe '#update_stock_if_catalogue_return' do
    let(:customer) { create(:account, user_type: 'buyer') }
    let(:order) { create(:shopping_cart_order, customer: customer) }
    let(:catalogue) { create(:catalogue, stocks: 10) }
    let!(:warehouse_catalogue) { create(:warehouse_catalogue, catalogue: catalogue, stocks: 5) }

    context 'when order status is qc_passed' do
      let(:order_status) { create(:order_status, status: 'qc_passed') }

      it 'increments stock in catalogue and warehouse' do
        order_item = create(:shopping_cart_order_item,
                            catalogue: catalogue,
                            quantity: 3,
                            order: order,
                            order_status: order_status)

        expect {
          order_item.update(quantity: 3) # triggers after_update callback
        }.to change { catalogue.reload.stocks }.by(3)
         .and change { warehouse_catalogue.reload.stocks }.by(3)
      end
    end

    context 'when order status is rejected' do
      let(:order_status) { create(:order_status, status: 'rejected') }

      it 'increments stock in catalogue and warehouse' do
        order_item = create(:shopping_cart_order_item,
                            catalogue: catalogue,
                            quantity: 2,
                            order: order,
                            order_status: order_status)

        expect {
          order_item.update(quantity: 2)
        }.to change { catalogue.reload.stocks }.by(2)
         .and change { warehouse_catalogue.reload.stocks }.by(2)
      end
    end

  end
end
