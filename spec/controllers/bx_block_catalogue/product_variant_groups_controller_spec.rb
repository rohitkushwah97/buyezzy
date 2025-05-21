require 'rails_helper'

RSpec.describe BxBlockCatalogue::ProductVariantGroupsController, type: :controller do

  before do
    @account = FactoryBot.create(:account, user_type: 'seller')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @catalogue = create(:catalogue)
    @product_content = create(:product_content, catalogue: @catalogue)
    @catalogue_variant = create(:catalogue_variant, seller: @account)
    @product_variant_group = create(:product_variant_group, catalogue: @catalogue)
    @group_attributes = create_list(:group_attribute, 2, product_variant_group: @product_variant_group)
    @error_msg = "Product sku can't be blank"
  end

  let(:valid_params) do
    {
      _json: [
        {
          catalogue_variant_id: @catalogue_variant.id,
          product_sku: 'ABC123',
          group_attributes_attributes: [
            { attribute_name: 'Memory', option: '128' },
            { attribute_name: 'Size', option: 'Large' }
          ]
        },
        { 
          catalogue_variant_id: @catalogue_variant.id,
          product_sku: 'ABC2123',
          group_attributes_attributes: [
            { attribute_name: 'Color', option: 'Red' },
            { attribute_name: 'Ram', option: '8' }
          ]
        }
      ]
    }
  end

  describe 'POST #create' do
    it 'creates a new product variant group' do
      post :create, params: valid_params.merge({catalogue_id: @catalogue.id,token: @token})
      expect(response).to have_http_status(:created)
    end

    it 'returns errors for invalid params' do
      post :create, params: {token: @token, catalogue_id: @catalogue.id, _json: [{catalogue_variant_id: @catalogue_variant.id, product_sku: '',group_attributes_attributes: [{ attribute_name: 'attr', option: 'value' }] }] }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("sku can't be blank")
    end
  end

  describe 'GET #index' do
    it 'returns a list of product variant groups' do
      get :index, params: { catalogue_id: @catalogue.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"][0]["id"]).to eq(@product_variant_group.id.to_s)
    end
  end

  describe 'GET #show' do
    it 'returns the details of a product variant group' do
      get :show, params: { catalogue_id: @catalogue.id, id: @product_variant_group.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["id"]).to eq(@product_variant_group.id.to_s)
      expect(JSON.parse(response.body)["data"]["attributes"]['product_bibc']).to eq(@product_variant_group.product_bibc)
    end
  end

  describe 'PUT #update' do
    it 'updates the product variant group' do
      put :update, params: {token: @token, catalogue_id: @catalogue.id, id: @product_variant_group.id, product_sku: 'UpdatedSKU' }
      expect(response).to have_http_status(:ok)
      expect(@product_variant_group.reload.product_sku).to eq('UpdatedSKU')
    end

    it 'returns errors for invalid params :update' do
      put :update, params: {token: @token, catalogue_id: @catalogue.id, id: @product_variant_group.id, product_sku: '' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include(@error_msg)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the product variant group' do
      delete :destroy, params: {token: @token, catalogue_id: @catalogue.id, id: @product_variant_group.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to include("Product variant Destroyed")
    end
  end
end
