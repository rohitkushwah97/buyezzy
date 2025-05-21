require 'rails_helper'

RSpec.describe Admin::DeliveryRequestsController, type: :controller do
  render_views

  let(:admin_user) { create(:admin_user) }
  let(:account) { create(:account, user_type: 'seller') }
  let(:customer) { create(:account, user_type: 'buyer') }
  let(:warehouse) { create(:warehouse, account: account) }
  let(:order_status) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Processing')}
  let(:order) {create(:shopping_cart_order, customer: customer, order_status: order_status )}
  let(:delivery_request) { create(:delivery_request, warehouse: warehouse, seller: account, order: order) }
  let(:valid_attributes) { {
    warehouse_name: warehouse.warehouse_name,
    seller_id: account.id,
    order_number: order.order_number,
    address_1: '123 Main St',
    address_2: 'Apt 456',
    status: 'Pending'
  }}

  before do
    sign_in admin_user
    order.update(order_status: order_status)
    @delivery_request_inx = FactoryBot.create(:delivery_request, warehouse: warehouse, seller: account, order: order)
  end

  describe 'GET #index' do
    it 'returns a success response index' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include(@delivery_request_inx.warehouse_name)
      expect(response.body).to include(@delivery_request_inx.order_number)
      expect(response.body).to include(@delivery_request_inx.status)
      expect(response.body).to include(admin_seller_account_path(@delivery_request_inx.seller))
    end

    it 'returns a success response and filters by warehouse_name' do
      
      get :index, params: { q: { warehouse_name_eq: @delivery_request_inx.warehouse_name } }
      
      expect(assigns(:delivery_requests)).to include(@delivery_request_inx)
    end

    it 'returns a success response and filters by order_number' do
      
      get :index, params: { q: { order_number_eq: order.order_number } }
      
      expect(assigns(:delivery_requests)).to include(@delivery_request_inx)
    end

    it 'returns a success response and filters by status' do
      
      get :index, params: { q: { status_eq: 'pending' } }
      
      expect(assigns(:delivery_requests)).to include(@delivery_request_inx)
    end

    it 'returns a success response and filters by created_at' do
      
      get :index, params: { q: { created_at_gteq: @delivery_request_inx.created_at.strftime("%Y-%m-%d 00:00:00"), created_at_lteq: @delivery_request_inx.created_at.strftime("%Y-%m-%d 23:59:59") } }
      
      expect(assigns(:delivery_requests)).to include(@delivery_request_inx)
    end

    it 'returns a success response and filters by updated_at' do
      
      get :index, params: { q: { updated_at_gteq: @delivery_request_inx.updated_at.strftime("%Y-%m-%d 00:00:00"), updated_at_lteq: @delivery_request_inx.updated_at.strftime("%Y-%m-%d 23:59:59") } }
      
      expect(assigns(:delivery_requests)).to include(@delivery_request_inx)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response show' do
      get :edit, params: { id: delivery_request.id }
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new delivery request with correct order and warehouse' do
        expect {
          post :create, params: { delivery_request: valid_attributes }
        }.to change(BxBlockOrderManagement::DeliveryRequest, :count).by(1)

        expect(BxBlockOrderManagement::DeliveryRequest.last.order_id).to eq(order.id)
        expect(BxBlockOrderManagement::DeliveryRequest.last.warehouse_id).to eq(warehouse.id)
      end
    end
  end
end
