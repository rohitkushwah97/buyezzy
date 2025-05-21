require 'rails_helper'

RSpec.describe AccountBlock::UserDeliveryAddressesController, type: :controller do

  before(:all) do
    @account = create(:account, user_type: 'buyer')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @user_delivery_address = create(:user_delivery_address, account: @account)
  end

  let(:valid_params) do
    {
      token: @token, 
      account_id: @account.id,
      data: {
        attributes: {
           "first_name": "test",
            "last_name": "user",
            "phone_number": "919922334453",
            "address_1": "address 1",
            "address_2": "address 2",
            "city": "Bangalore",
            "state": "Karnataka",
            "zip_code": "560076",
            "address_type": "Home",
            "is_default": true 
        }
      }
    }
  end

  describe 'GET index' do
    it 'returns a list of user delivery addresses' do
      get :index, params: {account_id: @account.id, token: @token }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    it 'returns a user delivery address' do
      get :show, params: {account_id: @account.id, id: @user_delivery_address.id, token: @token }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do

    it 'renders errors if creation fails' do
      post :create, params: {
        token: @token, 
        account_id: @account.id,
        data: {
          attributes: {
            first_name: nil
          }
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include("First name can't be blank")
    end

    it 'creates a new user delivery address' do
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
      expect(AccountBlock::UserDeliveryAddress.last.account).to eq(@account)
    end
  end

  describe 'PATCH update' do
    it 'updates an existing user delivery address' do
      patch :update, params: valid_params.merge(id: @user_delivery_address.id)
      expect(response).to have_http_status(:ok)
    end

    it 'renders errors if update fails' do
      patch :update, params: {
        token: @token, 
        account_id: @account.id,
        id: @user_delivery_address.id,
        data: {
          attributes: {
            address_1: nil
          }
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include("Address 1 can't be blank")
    end

    it 'updates an existing user delivery address and modifies associated order address_id' do

      order = create(:shopping_cart_order, customer: @account)
      # @user_delivery_address.update(is_default: true)

      expect(order.address_id).to be_nil

      patch :update, params: valid_params.merge(id: @user_delivery_address.id, is_default: true)

      expect(response).to have_http_status(:ok)

      order.reload

      expect(order.address_id).to eq(@user_delivery_address.id)
    end
  end

  describe 'DELETE destroy' do
    it 'destroys a user delivery address' do
      delete :destroy, params: {account_id: @account.id,token: @token, id: @user_delivery_address.id }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['meta']['message']).to eq('Delivery Address Removed')
    end
  end    
end
