require 'rails_helper'

RSpec.describe BxBlockCatalogue::BarcodesController, type: :controller do

  before do
    @account = FactoryBot.create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @catalogue = create(:catalogue)
    @barcode = create(:barcode, catalogue: @catalogue)
  end

  describe 'GET index' do
    it 'returns a list of barcodes for a specific catalogue' do
      barcode = create(:barcode, catalogue: @catalogue)
      get :index, params: { catalogue_id: @catalogue.id, token: @token }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(BxBlockCatalogue::Barcode.count)
    end
  end

  describe 'GET show' do
    it 'returns the details of a specific barcode' do
      get :show, params: { catalogue_id: @catalogue.id, id: @barcode.id, token: @token }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['id']).to eq(@barcode.id)
    end

    it 'returns an error if barcode does not exist' do
      get :show, params: { catalogue_id: @catalogue.id, id: 999, token: @token }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq("Barcode with id 999 doesn't exist")
    end
  end

  describe 'POST create' do
    let(:barcode_params) { { bar_code: '12345' } }

    it 'creates a new barcode associated with the specified catalogue' do
      post :create, params: { catalogue_id: @catalogue.id, barcode: barcode_params, token: @token }

      expect(response).to have_http_status(:created)
      expect(BxBlockCatalogue::Barcode.last.catalogue).to eq(@catalogue)
    end

    it 'returns an error if barcode creation fails' do
      post :create, params: { catalogue_id: @catalogue.id, barcode: {bar_code: ''}, token: @token }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key('bar_code')
    end
  end

  describe 'Patch update' do
    let(:barcode_params) { { bar_code: '1up45' } }

    it 'update a barcode associated with the specified catalogue' do
      patch :update, params: {id: @barcode.id, catalogue_id: @catalogue.id, barcode: barcode_params, token: @token }

      expect(response).to have_http_status(:ok)
      expect(BxBlockCatalogue::Barcode.last.catalogue).to eq(@catalogue)
    end

    it 'returns an error if barcode update fails' do
      patch :update, params: { id: @barcode.id, catalogue_id: @catalogue.id, barcode: {bar_code: ''}, token: @token }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['bar_code'][0]).to eq("can't be blank")
    end
  end
end
