require 'rails_helper'

RSpec.describe BxBlockCatalogue::CatalogueVariantsController, type: :controller do
  before(:each) do
    @account = FactoryBot.create(:account, user_type: 'seller')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @catalogue = FactoryBot.create(:catalogue)
    @catalogue_variant = FactoryBot.create(:catalogue_variant, seller: @account)
    @variant_attribute = create(:variant_attribute, catalogue_variant: @catalogue_variant)
    @atrribute_option = create(:attribute_option, variant_attribute: @variant_attribute)
    @micro_category = create(:micro_category)
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        token: @token,
        seller_id: @account.id,
        data: {
          attributes: {
            group_name: Faker::Lorem.word,
            micro_category_id: @micro_category.id,
            variant_attributes_attributes: [
              {
                attribute_name: 'size',
                attribute_options_attributes: [
                  { option: '6.1' },
                  { option: '6.7' }
                ]
              },
              {
                attribute_name: 'color',
                attribute_options_attributes: [
                  { option: 'red' },
                  { option: 'blue' }
                ]
              }
            ]
          }
        }
      }
    end

    context 'with valid attributes' do
      it 'creates a new CatalogueVariant' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'returns unprocessable entity status' do
        invalid_params = valid_params.deep_merge(data: { attributes: { group_name: nil } })
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    it '#index returns a success response' do
      get :index, params: { token: @token }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it '#show returns a success response' do
      get :show, params: { id: @catalogue_variant.id, token: @token}
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    let(:updated_group_name) { 'updated group' }
    let(:valid_update_params) do
      {
        token: @token,
        seller_id: @account.id,
        id: @catalogue_variant.id,
        data: {
          attributes: {
            group_name: updated_group_name,
            variant_attributes_attributes: [
              {
                id: @catalogue_variant.variant_attributes.first.id,
                attribute_name: 'size',
                attribute_options_attributes: [
                  { id: @catalogue_variant.variant_attributes.first.attribute_options.first.id, option: 'new option' }
                ]
              }
            ]
          }
        }
      }
    end

    it 'updates the CatalogueVariant' do
      put :update, params: valid_update_params.merge(token: @token)
      @catalogue_variant.reload
      expect(@catalogue_variant.group_name).to eq(updated_group_name)
    end
  end

  describe 'GET #destroy' do
    it '#destroy returns a success response' do
      get :destroy, params: { id: @catalogue_variant.id, token: @token}
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Variant group destroyed")
    end

     it '#destroy returns a error if variant exists' do
      variant_group = create(:product_variant_group, catalogue_variant_id: @catalogue_variant.id)
      get :destroy, params: { id: @catalogue_variant.id, token: @token}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["base"][0]).to eq("Selected group has variants linked to it. Please review and delete the variants to delete the group.")
    end
  end
end
