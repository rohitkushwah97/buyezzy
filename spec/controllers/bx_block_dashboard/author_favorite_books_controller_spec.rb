require 'rails_helper'

RSpec.describe BxBlockDashboard::AuthorFavoriteBooksController, type: :controller do

  before do
    @seller = create(:account, user_type: 'seller')
    @catalogues = create_list(:catalogue,8, seller: @seller)
    @favorite_book_catalogues_attributes = @catalogues.map do |catalogue|
      { catalogue_id: catalogue.id }
    end
    @author_favorite_book = create(:author_favorite_book, title: 'Title1', status: true, favorite_book_catalogues_attributes: @favorite_book_catalogues_attributes)
    @params_tp = {title: 'Title1', favorite_book_catalogues_attributes: @favorite_book_catalogues_attributes}
  end
  
  describe 'GET #index' do
    it 'returns a successful response with a list of fav book' do
      get :index

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockDashboard::AuthorFavoriteBook.all.count)
    end

    it 'returns a successful response with a list of fav book filter' do
      author_favorite_book_inx = create(:author_favorite_book, title: 'Title1', favorite_book_catalogues_attributes: @favorite_book_catalogues_attributes)
      get :index, params: {title_contains: 'title2'}

      parsed_response_1 = JSON.parse(response.body)
      expect(parsed_response_1['data'][0]['attributes']['title']).to eq(author_favorite_book_inx.title)
    end
  end

  describe 'GET #show' do

    it 'returns a successful response with the details of a fav book' do
      get :show, params: { id: @author_favorite_book.id }

      expect(response).to have_http_status(:success)
      parsed_response_2 = JSON.parse(response.body)
      expect(parsed_response_2['data']['id']).to eq(@author_favorite_book.id.to_s)
    end

  end

   describe 'GET #latest_author_favorite' do

    it 'returns a successful response with the details of latest fav book' do
      get :latest_author_favorite

      expect(response).to have_http_status(:success)
      parsed_response_3 = JSON.parse(response.body)
      expect(parsed_response_3['data']['id']).to eq(@author_favorite_book.id.to_s)
    end

  end
end
