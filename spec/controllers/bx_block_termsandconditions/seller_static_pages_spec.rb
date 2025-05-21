require 'rails_helper'

RSpec.describe BxBlockTermsandconditions::SellerStaticPagesController, type: :controller do

  # before(:all) do
  #   @account = create(:account)
  #   @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  # end

  describe 'GET index' do
    it 'renders a list of seller static as JSON' do
      seller_static_page1 = create(:seller_static_page, status: true)
      seller_static_page2 = create(:seller_static_page, status: true)
      
      get :index
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_an(Array)
      expect(response.body).to include(seller_static_page1.title)
      expect(response.body).to include(seller_static_page2.content)
    end
  end

  describe 'GET show' do
    it 'renders the details of a seller static page as JSON' do
      seller_static_page = create(:seller_static_page)
      
      get :show, params: { id: seller_static_page.id }
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_a(Hash)
      expect(response_data['title']).to eq(seller_static_page.title)
      expect(response_data['content']).to eq(seller_static_page.content)
    end

    it 'error seller static page not found' do
      
      get :show, params: { id: 999 }
      
      expect(response).to have_http_status(:not_found)
      response_data_1 = JSON.parse(response.body)
      expect(response_data_1['errors'][0]).to eq('Record not found')
    end
  end

  describe 'DELETE delete_static_pages' do

    let!(:page1) { create(:seller_static_page, title: 'page1') }
    let!(:page2) { create(:seller_static_page, title: 'page2') }

    context 'with valid IDs' do
      it 'deletes the specified pages' do
        expect {
          delete :delete_static_pages, params: { ids: [page1.id, page2.id] }
        }.to change(BxBlockTermsandconditions::SellerStaticPage, :count).by(-2)

        expect(response).to have_http_status(:ok)
        response_data = JSON.parse(response.body)
        expect(response_data['message']).to eq('Pages deleted successfully')
      end
    end

    context 'with no IDs provided' do
      it 'returns an error' do
        delete :delete_static_pages, params: { ids: [] }
        
        expect(response).to have_http_status(:unprocessable_entity)
        response_data = JSON.parse(response.body)
        expect(response_data['error']).to eq('No IDs provided')
      end
    end
  end

end
