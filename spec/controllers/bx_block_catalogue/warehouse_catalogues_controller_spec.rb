require 'rails_helper'

RSpec.describe BxBlockCatalogue::WarehouseCataloguesController, type: :controller do
  let(:account) { FactoryBot.create(:account, user_type: 'seller') }
  let(:token) { BuilderJsonWebToken.encode(account.id, token_type: 'login') }
  let(:warehouse) { FactoryBot.create(:warehouse, account: account) }
  let(:catalogue) { FactoryBot.create(:catalogue, seller: account) }
  let(:catalogue_2) { FactoryBot.create(:catalogue, seller: account) }
  let(:product_variant_group) { FactoryBot.create(:product_variant_group, catalogue: catalogue) }
  let(:group_attribute) {FactoryBot.create(:group_attribute, product_variant_group: product_variant_group)}
  let(:warehouse_catalogue) { FactoryBot.create(:warehouse_catalogue,catalogue: catalogue, product_variant_group: product_variant_group, stocks: 12) }

  describe 'POST create' do
    it 'creates a new warehouse_catalogue' do
      expect {
        post :create, params: {token: token, warehouse_id: warehouse.id, warehouse_catalogue: { catalogue_id: catalogue.id, product_variant_group_id: product_variant_group.id, stocks: 100 } }
      }.to change(BxBlockCatalogue::WarehouseCatalogue, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it 'renders errors if warehouse_catalogue creation fails' do
      existing_warehouse_catalogue = warehouse.warehouse_catalogues.create(catalogue: catalogue, product_variant_group: product_variant_group)

      post :create, params: {
        token: token,
        warehouse_id: warehouse.id,
        warehouse_catalogue: {
          catalogue_id: catalogue.id,
          product_variant_group_id: product_variant_group.id,
          stocks: 100
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include(
        "This catalogue is already exist in this warehouse"
        )
    end
  end

  describe 'GET show' do
    it 'returns the warehouse_catalogue' do
      group_attribute = FactoryBot.create(:group_attribute, product_variant_group: product_variant_group)
      warehouse_catalogue = FactoryBot.create(:warehouse_catalogue, warehouse: warehouse, catalogue: catalogue, product_variant_group: product_variant_group)
      product_variant_group.group_attributes.reload
      get :show, params: {token: token, warehouse_id: warehouse.id, id: warehouse_catalogue.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(BxBlockCatalogue::WarehouseCatalogueSerializer.new(warehouse_catalogue).serializable_hash.to_json)
      expect(JSON.parse(response.body)['data']['attributes']['selected_product_variant']['group_attributes'][0]).to have_key('attribute_name')
    end
  end

  describe 'PUT update' do
    it 'updates the warehouse_catalogue' do
      put :update, params: {token: token, warehouse_id: warehouse.id, id: warehouse_catalogue.id, warehouse_catalogue: { stocks: 200 } }

      expect(response).to have_http_status(:ok)
      expect(warehouse_catalogue.reload.stocks).to eq(200)
    end

    it 'error updates the warehouse_catalogue' do
      put :update, params: {token: token, warehouse_id: warehouse.id, id: warehouse_catalogue.id, warehouse_catalogue: { stocks: 201, catalogue_id: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include(
        "Catalogue must exist"
        )
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the warehouse_catalogue' do
      delete :destroy, params: {token: token, warehouse_id: warehouse.id, id: warehouse_catalogue.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq("Warehouse catalogue deleted successfully")
    end
  end

  describe 'GET index' do
    before do
      @warcatalogue =  FactoryBot.create(:warehouse_catalogue, warehouse: warehouse, catalogue: catalogue)
    end
    it 'returns all warehouse_catalogues for the warehouse' do
     
      get :index, params: {token: token, warehouse_id: warehouse.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns searched warehouse_catalogues for the warehouse' do

      get :index, params: {token: token, warehouse_id: warehouse.id, search_query: @warcatalogue.catalogue.sku }

      expect(JSON.parse(response.body)['data'][0]['id']).to eq(@warcatalogue.id.to_s) 
    end
  end

end
