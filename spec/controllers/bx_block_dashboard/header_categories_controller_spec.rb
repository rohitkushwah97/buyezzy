require 'rails_helper'

RSpec.describe BxBlockDashboard::HeaderCategoriesController, type: :controller do

  before do
    BxBlockDashboard::HeaderCategory.all.delete_all
    @header_category = create(:header_category)
  end

  describe 'GET #index' do
    it 'returns a successful response with a list of header categories' do
      category_categories = create_list(:header_category, 3) 

      get :index

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockDashboard::HeaderCategory.all.count)
    end
  end

  describe 'GET #show' do

    it 'returns a successful response with the details of a header category' do
      get :show, params: { id: @header_category.id }

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']['id']).to eq(@header_category.id.to_s)
      expect(parsed_response['data']['attributes']['category']).to have_key("category_image")
      expect(parsed_response['data']['attributes']['category']).to have_key("header_image")
      expect(parsed_response['data']['attributes']['category']).to have_key("created_at")
      expect(parsed_response['data']['attributes']['category']).to have_key("updated_at")
      expect(parsed_response['data']['attributes']['category']).to have_key("created_at")
      expect(parsed_response['data']['attributes']['category']['name']).to eq(@header_category.category.name)
    end
  end
end