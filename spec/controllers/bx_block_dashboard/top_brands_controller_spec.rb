require 'rails_helper'

RSpec.describe BxBlockDashboard::TopBrandsController, type: :controller do

  before do
    BxBlockDashboard::TopBrand.all.delete_all
    @top_brand = create(:top_brand)
  end
  
  describe 'GET #index' do
    it 'returns a successful response with a list of top brands' do
      top_brands = create_list(:top_brand, 3) 

      get :index

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockDashboard::TopBrand.all.count)
    end
  end

  describe 'GET #show' do

    it 'returns a successful response with the details of a top brand' do
      get :show, params: { id: @top_brand.id }

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']['id']).to eq(@top_brand.id.to_s)
    end

  end
end
