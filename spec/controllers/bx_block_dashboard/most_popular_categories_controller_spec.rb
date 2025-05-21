require 'rails_helper'

RSpec.describe BxBlockDashboard::MostPopularCategoriesController, type: :controller do

  before do
    BxBlockDashboard::MostPopularCategory.all.delete_all
    @popular_category = create(:most_popular_category)
  end

  describe 'GET #index' do
    it 'returns a successful response with a list of popular categories' do
      popular_categories = create_list(:most_popular_category, 3) 

      get :index

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockDashboard::MostPopularCategory.all.count)
    end
  end

  describe 'GET #show' do

    it 'returns a successful response with the details of a popular category' do
      get :show, params: { id: @popular_category.id }

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']['id']).to eq(@popular_category.id.to_s)
    end
  end
end
