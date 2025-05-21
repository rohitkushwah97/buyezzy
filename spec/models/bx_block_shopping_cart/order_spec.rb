require 'rails_helper'

RSpec.describe BxBlockShoppingCart::Order, type: :model do
  let(:customer) { FactoryBot.create(:account) }
  let(:order_status) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Scheduled') }
  let(:status_ordered) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Ordered') }
  let(:status_ongoing) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'On Going') }
  let(:order) { described_class.new(customer: customer, order_status: order_status) }
  let(:order2) { FactoryBot.create(:shopping_cart_order, customer: customer, order_status: order_status) }
  let(:seller) { FactoryBot.create(:account, user_type: "seller") }
  let(:catalogue) { FactoryBot.create(:catalogue, seller: seller) }
  let(:warehouse) { FactoryBot.create(:warehouse, account: seller) }
  let(:warehouse_catalogue) { FactoryBot.create(:warehouse_catalogue, warehouse: warehouse, catalogue: catalogue, stocks: 10) }
  let(:order_item) { FactoryBot.create(:shopping_cart_order_item, order: order2, catalogue: catalogue, quantity: 5) }

  describe '#assign_default_order_status' do
    it 'assigns default order status before creation' do
      order.save
      expect(order.order_status.name).to eq('Scheduled')
    end
  end

  describe '#check_order_status' do

    it 'allows updating order status if it was not completed' do
      order.order_status = status_ongoing

      expect(order).to be_valid
    end
  end

  describe '#set_current_order' do
    it 'sets the current order for the customer after creation' do
      expect(customer.current_order).to be_nil

      order.save

      expect(customer.current_order).to eq(order.id)
    end
  end

  describe '#update_current_order' do
    it 'clears the current order for the customer when order is placed' do
      order.save
      expect(customer.current_order).to eq(order.id)

      order.update(order_status: status_ordered)

      expect(customer.reload.current_order).to be_nil
    end

    it 'does not clear the current order for the customer if order is not completed' do
      order.save
      expect(customer.current_order).to eq(order.id)

      order.update(order_status: status_ongoing)

      expect(customer.reload.current_order).to eq(order.id)
    end
  end

  describe '#add_order_number' do
    it 'adds an order number before creation' do
      expect(order.order_number).to be_nil

      order.save

      expect(order.order_number).not_to be_nil
    end
  end

  describe '.next_order_number' do
    it 'generates the next order number' do
      FactoryBot.create(:shopping_cart_order, order_number: '0000-0000000000', customer: customer)

      last_order_number = described_class.last.order_number
      expected_next_order_number = last_order_number.succ

      expect(described_class.next_order_number).to eq(expected_next_order_number)
    end
  end

  describe 'assign_shipping_address' do
     it 'updates address_id with user_delivery_address id' do
      user_delivery_address = FactoryBot.create(:user_delivery_address,account: customer,is_default: true)
      order = FactoryBot.create(:shopping_cart_order, customer: customer)

      expect(order.customer).to eq(customer)
      expect(order.address_id).to eq(user_delivery_address.id)
    end
  end

  describe '#update_stocks' do
    before do
      order2.order_items << order_item
      catalogue.warehouse_catalogues << warehouse_catalogue
      order2.reload
      catalogue.reload
    end
    context 'when the stock is sufficient' do
      it 'decrements the stock by the order item quantity' do
        order2.update(order_status: status_ongoing)
        order2.update(order_status: status_ordered)
        expect(catalogue.reload.stocks).to eq(5)
      end
    end

    context 'when the stock is not sufficient' do
      let(:order3) { FactoryBot.create(:shopping_cart_order, customer: customer, order_status: order_status) }
      let(:order_item2) { FactoryBot.create(:shopping_cart_order_item, order: order3, catalogue: catalogue, quantity: 10) }

      it 'sets the stock to zero' do
        order3.order_items << order_item2
        order3.reload
        warehouse_catalogue.update(stocks: 10)
        catalogue.reload
        order3.update(order_status: status_ongoing)
        order3.update(order_status: status_ordered)
        expect(catalogue.reload.stocks).to eq(0)
      end
    end
  end

   describe '#check_warehouse_catalogue_stocks' do
    let(:order4) { FactoryBot.create(:shopping_cart_order, customer: customer, order_status: order_status) }
    let(:order_item3) { FactoryBot.create(:shopping_cart_order_item, order: order4, catalogue: catalogue, quantity: 5) }

    before do
      order4.order_items << order_item3
      catalogue.warehouse_catalogues << warehouse_catalogue
      order4.reload
      catalogue.reload
    end

    context 'when the stock is sufficient' do
      it 'allows the order status to be updated to ordered' do
        warehouse_catalogue.update(stocks: 10)
        order4.update(order_status: status_ordered)
        expect(order4.errors[:order_items]).to be_empty
      end
    end

    context 'when the stock is not sufficient' do
      it 'adds an error to the order' do
        warehouse_catalogue.update(stocks: 2)
        order4.update(order_status: status_ordered)
        catalogue.reload
        out_of_stock_details = [{ id: catalogue.id, product_title: catalogue.product_title }]
        expect(order4.errors[:order_items]).to include(hash_including(:out_of_stock => out_of_stock_details))
      end
    end
  end

end
