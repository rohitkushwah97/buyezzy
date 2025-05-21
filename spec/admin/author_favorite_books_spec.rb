require 'rails_helper'

RSpec.describe Admin::AuthorFavoriteBooksController, type: :controller do  
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @seller = create(:account, user_type: 'seller')
    @catalogues = create_list(:catalogue,8, seller: @seller)
    favorite_book_catalogues_attributes = @catalogues.map do |catalogue|
      { catalogue_id: catalogue.id }
    end
    @author_favorite_book = create(:author_favorite_book, title: 'Title1', favorite_book_catalogues_attributes: favorite_book_catalogues_attributes)
    @params_tp = {title: 'Title1', favorite_book_catalogues_attributes: favorite_book_catalogues_attributes}
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: @author_favorite_book.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

end
