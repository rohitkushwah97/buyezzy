require 'rails_helper'

RSpec.describe BxBlockCatalogue::CatalogueOffersController, type: :controller do

  before do
    @account = FactoryBot.create(:account, user_type: 'seller')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end

  let(:catalogue) { create(:catalogue) }
  let(:product_content) { create(:product_content, catalogue: catalogue) }
  let(:deal) { create(:deal, status: true) }
  let(:deal_catalogue) { create(:deal_catalogue, deal: deal, catalogue: catalogue, seller: @account) }
  let(:catalogue_offer) { create(:catalogue_offer, catalogue: catalogue) }

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { catalogue_id: catalogue.id, id: catalogue_offer.id, token: @token }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        data: {
          type: 'catalogue_offer',
          attributes: {
            barcode_id: create(:barcode, catalogue: catalogue).id,
            price_info: 'Some price info',
            bar_code_info: 'Some barcode info',
            warranty: '1 year'
          }
        }
      }
    end

    it 'creates a new catalogue offer' do
      post :create, params: valid_params.merge(catalogue_id: catalogue.id,token: @token)
      expect(response).to have_http_status(:created)
    end

    it 'returns error if deal already exists' do
      deal = create(:deal, status: true)
      catalogue = create(:catalogue, seller: @account)
      deal_catalogue = create(:deal_catalogue, deal: deal, catalogue: catalogue, seller: @account)
      valid_params[:data][:attributes][:status] = true

      post :create, params: valid_params.merge(catalogue_id: catalogue.id, token: @token)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Catalogue Cannot create an active offer as there is an active and approved deal for this product.")
    end
  end

  describe 'PATCH #update' do
    let(:valid_params) do
      {
        data: {
          type: 'catalogue_offer',
          attributes: {
            price_info: 'Updated price info',
            sale_price: 230,
            bar_code_info: 'Updated barcode info',
            warranty: '2 years'
          }
        }
      }
    end

    it 'updates the catalogue offer' do
      catalogue.deal_catalogues << deal_catalogue
      patch :update, params: valid_params.merge(catalogue_id: catalogue.id, id: catalogue_offer.id, token: @token)
      expect(catalogue_offer.reload.warranty).to eq(valid_params[:data][:attributes][:warranty])
      expect(deal_catalogue.reload.seller_price).to eq(valid_params[:data][:attributes][:sale_price])
    end
  end
end
