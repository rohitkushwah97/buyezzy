require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  render_views

  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:seller) { FactoryBot.create(:account, user_type: 'seller', company_or_store_name: "byezzy") }
  let(:customer) { FactoryBot.create(:account, user_type: 'buyer') }
  let(:catalogue) {create(:catalogue, seller: seller)}
  let(:shipping_address) {create(:user_delivery_address, account: customer, is_default: true)}
  let(:order_status) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'on_going') }
  let(:order) { FactoryBot.create(:shopping_cart_order, customer: customer, order_status: order_status, address_id: shipping_address.id) }
  let(:order_items) {FactoryBot.create_list(:shopping_cart_order_item, 2, catalogue: catalogue, order: order)}

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    before do
    @orders = create_list(:shopping_cart_order,2,customer: customer, order_status: order_status) 
    @order_items = create_list(:shopping_cart_order_item,2,order: @orders.first, order_status: order_status) 
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@orders.last.order_number.to_s)
      expect(response.body).to include(@orders.last.total_items.to_s)
      expect(response.body).to include("No")
    end

    it 'filters by order number' do
      get :index, params: {q: {order_number_eq: @orders.first.order_number}}
      expect(response.body).to include(@orders.first.order_number.to_s)
    end

    it 'filters by total items' do
      get :index, params: {q: {total_items_eq: @orders.first.total_items}}
      expect(response.body).to include(@orders.first.total_items.to_s)
    end

    it 'filters by order status' do
      get :index, params: {q: {order_status_id_eq: @orders.first.order_status.id}}
      expect(response.body).to include(@orders.first.order_status.status)
    end

     it 'filters by order item status' do
      get :index, params: {q: {order_items_order_status_id_in: @orders.first.order_status.id}}
      expect(response.body).to include(@orders.first.order_status.status)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: order.id }
      expect(response).to render_template(:show)
      expect(response.body).to include(order.id.to_s)
      expect(response.body).to include(order.total_fees.to_s)
      expect(response.body).to include(order.total_tax.to_s)
      expect(response.body).to include(order.final_price.to_s)
      expect(response.body).to include("No")
      expect(response.body).to include("Customer")
      expect(response.body).to include("Sellers")
      expect(response.body).to include("Shipping Address")
      expect(response.body).to include("Order Items")
      expect(response.body).to include("Catalogue")
      seller_names = order.sellers.map { |seller| link_to(seller.full_name, admin_seller_account_path(seller)) }.join(', ')
      expect(response.body).to include(seller_names)
      address = order.shipping_address.attributes.slice(
        'first_name', 'last_name', 'address_1', 'address_2',
        'phone_number', 'state', 'city', 'zip_code', 'address_type'
        ).values.join(', ')
      expect(response.body).to include(address)
      expect(response.body).not_to include("Coupon Code")
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: order.id }
      expect(response).to render_template(:edit)
    end
  end

end

