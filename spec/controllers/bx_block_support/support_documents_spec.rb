require 'rails_helper'

RSpec.describe BxBlockSupport::SupportDocumentsController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end

  describe 'GET index' do
    it 'renders a list of terms policies as JSON' do
      support_document1 = create(:support_document)
      support_document2 = create(:support_document)
      
      get :index, params: {token: @token}
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_an(Array)
      expect(response.body).to include(support_document1.page_title)
      expect(response.body).to include(support_document2.content)
    end
  end

  describe 'GET show' do
    it 'renders the details of a terms policy as JSON' do
      support_document = create(:support_document)
      
      get :show, params: { id: support_document.id, token: @token }
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_a(Hash)
      expect(response_data['page_title']).to eq(support_document.page_title)
      expect(response_data['content']).to eq(support_document.content)
    end
  end

   describe 'DELETE delete_support_documents' do

    let!(:doc1) { create(:support_document) }
    let!(:doc2) { create(:support_document) }

    context 'with valid IDs' do
      it 'deletes the specified document' do
        expect {
          delete :delete_support_documents, params: { ids: [doc1.id, doc2.id] }
        }.to change(BxBlockSupport::SupportDocument, :count).by(-2)

        expect(response).to have_http_status(:ok)
        response_data = JSON.parse(response.body)
        expect(response_data['message']).to eq('Documents deleted successfully')
      end
    end

    context 'with no IDs provided' do
      it 'returns an error' do
        delete :delete_support_documents, params: { ids: [] }
        
        expect(response).to have_http_status(:unprocessable_entity)
        response_data = JSON.parse(response.body)
        expect(response_data['error']).to eq('No IDs provided')
      end
    end
  end

end
