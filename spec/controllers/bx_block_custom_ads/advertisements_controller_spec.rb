require 'rails_helper'

RSpec.describe BxBlockCustomAds::AdvertisementsController, type: :controller do
  before do
    @advertisement = create(:advertisement, status: 1)
  end

  describe 'GET index' do
    it 'returns a list of active advertisements' do
      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']).to eq('Successfully loaded')
      expect(JSON.parse(response.body)['advertisements']).not_to be_empty
    end
  end

  describe 'GET show' do
    it 'shows details of a specific advertisement' do
      get :show, params: { id: @advertisement.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']).to eq('Successfully loaded')
      expect(JSON.parse(response.body)['advertisement']['id']).to eq(@advertisement.id)
    end

    it 'returns an error if the advertisement does not exist' do
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors'][0]).to eq('Record not found')
    end
  end
end
