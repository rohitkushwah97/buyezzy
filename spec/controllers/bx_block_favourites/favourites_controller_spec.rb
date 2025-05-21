require 'rails_helper'

RSpec.describe BxBlockFavourites::FavouritesController, type: :controller do
  before do
    @account = FactoryBot.create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @favourite = create(:favourite, user: @account)
    @catalogue_0 = create(:catalogue)
    @favourite_2 = create(:favourite, user: @account, favouriteable_id: @catalogue_0.id)
    @account_2 = FactoryBot.create(:account)
    @token_2 = BuilderJsonWebToken.encode(@account_2.id, token_type: 'login')
    @catalogue = create(:catalogue)
    @product_variant = create(:product_variant_group, catalogue: @catalogue)
  end

  describe 'GET #index' do
    it 'returns a list of favourites for the user' do

      get :index, params: { token: @token }

      expect(response).to have_http_status(:ok)
      expect(response_body['data'][0]['attributes']['catalogue']['data']['id']).to eq(@favourite_2.favouriteable_id.to_s)
      favorites = response_body['data'].map { |fav| fav['attributes']['catalogue']['data']['id'].to_i }
      expect(favorites).to eq([ @favourite_2.favouriteable_id, @favourite.favouriteable_id])

    end

    it 'returns a list of favourites for the user sort by' do

      get :index, params: { token: @token, sort_by: 'whats_new' }

      expect(response).to have_http_status(:ok)
      expect(response_body['data'][0]['attributes']['catalogue']['data']['attributes']['created_at'].to_time.iso8601).to eq(@favourite_2.favouriteable.created_at.to_time.iso8601)

    end

    it 'returns an empty array if user has no favourites' do
      get :index, params: { token: @token_2 }

      expect(response).to have_http_status(:not_found)
      expect(response_body).to eq([])

    end
  end

  describe 'POST #create' do

    it 'creates a existing favourite for the user with valid parameters' do
      post :create, params: { token: @token, favouriteable_id: @catalogue.id, product_variant_group_id: @product_variant.id }

      expect(response).to have_http_status(:ok)
      expect(response_body['data']['attributes']['selected_product_variant']['id']).to eq(@product_variant.id)
    end

    it 'returns errors if creation fails' do
      post :create, params: { token: @token, favouriteable_id: @catalogue_0.id }

      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to eq("Product already exist in wishlist")
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys a favourite' do
      delete :destroy, params: {token: @token, id: @favourite.id }

      expect(response).to have_http_status(:ok)
      expect(response_body).to include('message' => 'Destroy successfully')
    end

    it 'returns not found if the favourite does not exist' do
      delete :destroy, params: {token: @token, id: 999 }

      expect(response).to have_http_status(:not_found)
    end
  end

  # Helper method to parse JSON response
  def response_body
    JSON.parse(response.body)
  end
end
