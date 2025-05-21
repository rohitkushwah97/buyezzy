require 'rails_helper'

RSpec.describe BxBlockOrderManagement::DeliveryRequestsController, type: :controller do
  let(:account) { create(:account, user_type: 'seller') }
  let(:customer) { create(:account, user_type: 'buyer') }
  let(:warehouse) { create(:warehouse, account: account) }
  let(:order_status) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Processing')}
  let(:order) {create(:shopping_cart_order, customer: customer)}
  let(:delivery_request) { create(:delivery_request, warehouse: warehouse, seller: account, order: order) }

  let(:valid_attributes) do
    {
      data: {
        attributes: {
          warehouse_id: warehouse.id, 
          warehouse_name: warehouse.warehouse_name, 
          order_number: order.order_number,
          address_1: '123 Main St',
          address_2: 'Apt 456',
        }
      }
    }
  end

  before(:each) do
    @token = BuilderJsonWebToken.encode(account.id)
    order.update(order_status: order_status)
  end

  describe 'GET #index' do
    it 'returns a success response index' do
      get :index, params: { token: @token }
      
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'returns a success response show' do
      get :show, params: { token: @token, id: delivery_request.id }
      
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do

      it 'renders a JSON response with the new delivery request' do
        post :create, params: { token: @token }.merge(valid_attributes)

        expect(response).to have_http_status(:created)  
        expect(response_body['data']['attributes']['warehouse_name']).to eq(warehouse.warehouse_name)   
      end
    end


    context 'with invalid params' do
      it 'renders a JSON response with errors for the new delivery request' do
        valid_attributes[:data][:attributes][:order_number] = "1234"
        post :create, params: valid_attributes.merge({ token: @token })
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include("Order number is invalid")
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid/invalid params' do
      let(:new_attributes) do
        {
          data: {
            attributes: {
              address_1: 'test add update'
            }
          }
        }
      end

      it 'updates the requested delivery request' do
        put :update, params: { token: @token, id: delivery_request.id }.merge(new_attributes)
        delivery_request.reload
        expect(response_body['data']['attributes']['address_1']).to eq(delivery_request.address_1)
        expect(response).to have_http_status(:ok)
      end

      it 'renders a JSON response with errors for the delivery request' do
        new_attributes[:data][:attributes][:address_1] = ""
        put :update, params: {token: @token, id: delivery_request.id }.merge(new_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include("Address 1 is missing or select geo location")
      end
      
    end

    # context 'with invalid params' do
    #   it 'renders a JSON response with errors for the delivery request' do
    #     new_attributes['data']['attributes']['address_1'] = ""
    #     put :update, params: {token: @token, id: delivery_request.id }.merge(new_attributes)
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response_body['errors']).to include("Address 1 is missing or select geo location")
    #   end
    # end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested delivery requested' do
      delete :destroy, params: { token: @token, id: delivery_request.id }
      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to include("Delivery request deleted succesfully!")
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end
end