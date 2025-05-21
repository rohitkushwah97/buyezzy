require 'rails_helper'
RSpec.describe BxBlockStoreManagement::StoresController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @brand = create(:brand)
    @store = create(:store, approve: true)
    @seller_account = create(:account, user_type: 'seller')
    @seller_token = BuilderJsonWebToken.encode(@seller_account.id, token_type: 'login')
    @store_params = attributes_for(:store)
  end

  describe 'GET index' do
    it 'returns a list of stores' do
      get :index, params: {token: @token}
      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockStoreManagement::Store.count)
    end
  end

  describe 'GET index_approved_stores' do
    it 'returns a list of approved stores' do
      create(:store, approve: true)
      create(:store, approve: false)
      get :index_approved_stores, params: { token: @token }
      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockStoreManagement::Store.where(approve: true).count)
    end
  end

  describe 'GET show' do
    it 'returns a specific store' do
      get :show, params: { id: @store.id, token: @token }
      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']['id']).to eq(@store.id.to_s)
      expect(parsed_response["data"]["attributes"]).to have_key("brand_trade_certificate")
    end

    it 'returns not found if the store does not exist' do
      get :show, params: { id: '0' , token: @token}
      expect(response).to have_http_status(:not_found)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Store with id 0 doesn't exists")
    end
  end

  describe 'POST create' do
    it 'creates a new store' do
      post :create, params: @store_params.merge({token: @token,brand_id: @brand.id})
      expect(response).to have_http_status(:created)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']['attributes']['store_name']).to eq(@store_params[:store_name])
    end

    it 'returns unprocessable entity with errors if store creation fails' do
      post :create, params: {token: @token}
      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to include("Store year can't be blank")
    end
  end

  describe 'PATCH update' do
    it 'updates a specific store' do
      new_store_name = 'New Store Name'
      patch :update, params: { id: @store.id, store_name: new_store_name, token: @token }
      expect(response).to have_http_status(:ok)
      @store.reload
      expect(@store.store_name).to eq(new_store_name)
    end

    it 'returns unprocessable entity with errors if store update fails' do
      patch :update, params: { id: @store.id, store_name: '', token: @token }
      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to include("Store name can't be blank")
    end
  end

  describe 'DELETE destroy' do
    it 'deletes a specific store' do
      delete :destroy, params: { id: @store.id, token: @token }
      expect(response).to have_http_status(:ok)
      expect(BxBlockStoreManagement::Store.exists?(@store.id)).to be_falsey
    end

    it 'returns not found if the store does not exist' do
      delete :destroy, params: { id: '0', token: @token }
      expect(response).to have_http_status(:not_found)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Store with id 0 doesn't exists")
    end
  end

  describe 'GET#seller_store_listing ' do
    context 'Get user stores listing' do
      it 'when user type nil' do
        get :seller_store_listing, params: {token: @token}
        expect(response.body).to eq("{\"errors\":[{\"message\":\"You are not authorized to access stores\"}]}")
      end

      it 'when user type seller' do
        @account.update(user_type: "seller")
        get :seller_store_listing, params: {token: @token}
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT#update_seller_store ' do
    context "update seller's store" do
      it 'when user type nil' do
        put :update_seller_store, params: {token: @token, id: @store.id}
        expect(response.body).to eq("{\"errors\":[{\"message\":\"You are not authorized to access stores\"}]}")
      end

      it 'when user type seller' do
        put :update_seller_store, params: {token: @seller_token, id: @store.id, store_name: 'dummy'}
        expect(response).to have_http_status(:ok)
      end

      it 'return error' do
        put :update_seller_store, params: {token: @seller_token, id: @store.id, store_name: nil}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq("{\"errors\":[\"Store name can't be blank\"]}")
      end
    end
  end

  describe 'DELETE delete_seller_store' do
    it "when delete seller's store" do
      @store.update(account_id: @seller_account.id)
      delete :delete_seller_store, params: { id: @store.id, token: @seller_token }
      expect(response).to have_http_status(:ok)
      expect(BxBlockStoreManagement::Store.exists?(@store.id)).to be_falsey
    end

    it 'when store does not exist with this seller' do
      delete :delete_seller_store, params: { id: '0', token: @seller_token }
      expect(response).to have_http_status(:not_found)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("This store not belongs to your account or not exists with id 0")
    end
  end

  describe 'POST create_seller_store' do
    it 'creates a new store for seller' do
      post :create_seller_store, params: @store_params.merge({token: @seller_token, brand_id: @brand.id})
      expect(response).to have_http_status(:created)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']['attributes']['store_name']).to eq(@store_params[:store_name])
    end

    it 'returns unprocessable entity with errors if store creation fails' do
      post :create_seller_store, params: {store_name: '', token: @seller_token}
      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to include("Store year can't be blank")
    end
  end
end
