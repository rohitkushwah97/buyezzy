require 'rails_helper'

RSpec.describe BxBlockCatalogue::WarehousesController, type: :controller do

  before do
    @account = FactoryBot.create(:account)
    @account1 = FactoryBot.create(:account, user_type: "seller")
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @token1 = BuilderJsonWebToken.encode(@account1.id, token_type: 'login')
    @warehouse = create(:warehouse, account: @account1)
    @catalogues = create_list(:catalogue, 3, seller: @account1)
    @error = "{\"errors\":[{\"message\":\"You are not authorized to access warehouse\"}]}"
    @user_authorization = "user not authorized"
  end

  let(:valid_params) {
    { warehouse: { warehouse_type: 'Type A', warehouse_name: 'Warehouse A' ,account_id: @account.id},token: @token }
  }

  describe "GET #index" do
    it "returns a successful response" do
      get :index, params: {token: @token}
      expect(response).to have_http_status(:ok)
    end

    it "returns warehouses in JSON format" do
      get :index, params: {token: @token}
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)  
      expect(json_response.last["warehouse_type"]).to eq(@warehouse.warehouse_type)
      expect(json_response.last["warehouse_name"]).to eq(@warehouse.warehouse_name)
      expect(json_response.last["warehouse_address_1"]).to eq(@warehouse.warehouse_address_1)
      expect(json_response.last["contact_number"]).to eq(@warehouse.contact_number)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new warehouse" do
        expect {
          post :create, params: valid_params
        }.to change(BxBlockCatalogue::Warehouse, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it "returns the created warehouse in JSON format" do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["warehouse_type"]).to eq(valid_params[:warehouse][:warehouse_type])
        expect(json_response["warehouse_name"]).to eq(valid_params[:warehouse][:warehouse_name])
        expect(json_response["warehouse_address_1"]).to eq(valid_params[:warehouse][:warehouse_address_1])
      end
    end

    context "with invalid params" do
      it "does not create a new warehouse" do
        expect {
          post :create, params: { warehouse: { warehouse_type: '' },token: @token }
        }.to_not change(BxBlockCatalogue::Warehouse, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

     describe 'GET #create_seller_warehouse' do
      it @user_authorization do
        get :seller_warehouse_listing, params:{ warehouse: {account_id: @account1.id}, token: @token }
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to eq(@error)
      end

    it "seller's warehouse listing" do
      warehouse = create(:warehouse, account: @account1)
      catalogue = FactoryBot.create(:catalogue, seller: @account1)
      product_variant_group = FactoryBot.create(:product_variant_group, catalogue: catalogue)
      warehouse_catalogue = FactoryBot.create(:warehouse_catalogue,warehouse: warehouse, catalogue: catalogue, product_variant_group: product_variant_group, stocks: 12)
      get :seller_warehouse_listing, params:{ warehouse: {account_id: @account1.id}, token: @token1 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'][0]['attributes']).to have_key('product_variant_groups')
    end
  end

   describe 'POST #create_seller_warehouse' do
      it @user_authorization do
        post :create_seller_warehouse, params: valid_params
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to eq(@error)
      end

    it "create seller's warehouse" do
      token = BuilderJsonWebToken.decode(@token)
      AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
      post :create_seller_warehouse, params: valid_params
      expect(response).to have_http_status(:created)
    end

    it "not create seller's warehouse" do
      token = BuilderJsonWebToken.decode(@token)
      AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
      post :create_seller_warehouse, params: { warehouse: { account_id: @account.id, warehouse_name: "", warehouse_address_1: "new one"},token: @token }     
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq("{\"errors\":[\"Warehouse name can't be blank\"]}")
    end
  end

  describe 'PUT #update_seller_warehouse' do
  it @user_authorization do
    put :update_seller_warehouse, params:  { warehouse: { id: @warehouse.id, account_id: @account1.id, warehouse_name: "dummy", warehouse_address_1: "new one"}, token: @token } 
    expect(response).to have_http_status(:forbidden)
    expect(response.body).to eq(@error)
  end

  it "update seller's warehouse" do
    token = BuilderJsonWebToken.decode(@token)  
    AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
    put :update_seller_warehouse, params:  { warehouse: { id: @warehouse.id,account_id: @account.id,  warehouse_name: "dummy", "catalogue_ids": @catalogues.map(&:id) }, token: @token }
    @warehouse.reload
    expect(response).to have_http_status(:ok)    
    expect(@warehouse).not_to be_nil
    expect(@warehouse.warehouse_name).to eq("dummy")
    expect(JSON.parse(response.body)["message"]["success"]).to eq(true)
  end

  # it "validation error on update" do
  #   # warehouse2 = create(:warehouse, account: @account1)
  #   # warehouse_catalogue = create(:warehouse_catalogue, warehouse: @warehouse, catalogue: @catalogues.last)
  #   put :update_seller_warehouse, params:  { warehouse: { id: warehouse2.id, account_id: @account1.id, "catalogue_ids": @catalogues.map(&:id) }, token: @token1 }
  #   expect(response).to have_http_status(:ok)    
  #   expect(JSON.parse(response.body)["message"]["success"]).to eq(false)
  # end

  it "not update seller's warehouse" do
    token = BuilderJsonWebToken.decode(@token)
    AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
    put :update_seller_warehouse, params:  { warehouse: { id: @warehouse.id, account_id: @account.id,  warehouse_name: "", warehouse_type: ''}, token: @token }     
    @warehouse.reload
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to eq("{\"errors\":[\"Warehouse name can't be blank\"]}")
  end
end

describe 'DELETE #delete_seller_warehouse' do
  it @user_authorization do
    delete :delete_seller_warehouse, params:{ warehouse: { id: @warehouse.id, account_id: @account1.id}, token: @token } 
    expect(response).to have_http_status(:forbidden)
    expect(response.body).to eq(@error)
  end

  it "delete seller's warehouse" do
    token = BuilderJsonWebToken.decode(@token)
    AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')

    expect {
      delete :delete_seller_warehouse, params:{ warehouse: { id: @warehouse.id, account_id: @account1.id}, token: @token }
    }.to change(BxBlockCatalogue::Warehouse, :count).by(-1)

    expect(response).to have_http_status(:ok)
  end
end
end