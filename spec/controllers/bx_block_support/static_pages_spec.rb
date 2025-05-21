require 'rails_helper'

RSpec.describe BxBlockSupport::StaticPagesController, type: :controller do
  
  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end

  let!(:support) { create(:static_page, title: "MyString", content: "MyText", status: true) }

  describe 'GET /bx_block_support/supports' do
    it 'returns a list of supports' do
      get :index, params: { token: @token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(BxBlockSupport::StaticPage.where(status: true).count)
    end
  end

  describe 'GET /bx_block_support/supports/:id' do
    it 'returns a single support' do
      get :show, params: { token: @token, id: support.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["title"]).to eq("MyString")
      expect(JSON.parse(response.body)["content"]).to eq("MyText")
      expect(JSON.parse(response.body)["status"]).to eq(true)
    end

  end

  describe 'DELETE delete_static_pages - footer' do

    let!(:page1) { create(:static_page, title: 'page1') }
    let!(:page2) { create(:static_page, title: 'page2') }

    context 'with valid IDs' do
      it 'deletes the specified pages' do
        expect {
          delete :delete_static_pages, params: { ids: [page1.id, page2.id] }
        }.to change(BxBlockSupport::StaticPage, :count).by(-2)

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
