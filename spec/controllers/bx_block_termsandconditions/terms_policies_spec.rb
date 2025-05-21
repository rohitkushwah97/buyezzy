require 'rails_helper'

RSpec.describe BxBlockTermsandconditions::TermsPoliciesController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end

  describe 'GET index' do
    it 'renders a list of terms policies as JSON' do
      terms_policy1 = create(:terms_policy)
      terms_policy2 = create(:terms_policy)
      
      get :index, params: {token: @token}
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_an(Array)
      expect(response.body).to include(terms_policy1.page_title)
      expect(response.body).to include(terms_policy2.content)
    end
  end

  describe 'GET show' do
    it 'renders the details of a terms policy as JSON' do
      terms_policy = create(:terms_policy)
      
      get :show, params: { id: terms_policy.id, token: @token }
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_a(Hash)
      expect(response_data['page_title']).to eq(terms_policy.page_title)
      expect(response_data['content']).to eq(terms_policy.content)
    end
  end

end
