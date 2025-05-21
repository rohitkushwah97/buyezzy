# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockShoppingCart::ReturnExchangeRequestsController, type: :controller do
  let(:customer) { create(:account, user_type: 'buyer') }
  let(:token) { BuilderJsonWebToken.encode(customer.id, token_type: 'login') }
  let(:order_status) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Delivered') }
  let(:order) { create(:shopping_cart_order, customer: customer) }
  let(:order_item) { create(:shopping_cart_order_item, order: order) }

  before do
    order.update(order_status: order_status)
  end
  let(:return_exchange_request) { create(:return_exchange_request, order: order, customer: customer) }
  let(:valid_attributes) do
    {
      order_number: order.order_number,
      request_type: 'return',
      request_reason: 'Defective product',
      description: 'The product is defective and needs to be returned',
      order_item_ids: [order_item.id]
    }
  end
  let(:invalid_attributes) do
    { order_number: order.order_number, request_type: nil, request_reason: nil, description: nil }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      return_exchange_request = create(:return_exchange_request, customer: customer, order: order)
      get :index, params: { token: token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)[0]['id']).to eq(return_exchange_request.id)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: return_exchange_request.id, token: token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(return_exchange_request.id)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ReturnExchangeRequest' do
        expect do
          post :create, params: { token: token, return_exchange_request: valid_attributes }
        end.to change(BxBlockShoppingCart::ReturnExchangeRequest, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new return_exchange_request' do
        post :create, params: { token: token, return_exchange_request: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid order' do
      it 'renders a JSON response with not_found for the new return_exchange_request' do
        invalid_attributes[:order_number] = '345678'
        post :create, params: { token: token, return_exchange_request: invalid_attributes }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Order not found')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested return_exchange_request' do
      delete :destroy, params: { token: token, id: return_exchange_request.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
