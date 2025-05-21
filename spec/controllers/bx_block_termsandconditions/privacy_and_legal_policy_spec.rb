require 'rails_helper'

RSpec.describe BxBlockTermsandconditions::PrivacyAndLegalPolicyController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end

  describe 'GET index' do
    it 'renders a list of privacy and legal policy as JSON' do
      privacy = create(:privacy_and_legal_policy)
      privacy1 = create(:privacy_and_legal_policy)
      
      get :index, params: {token: @token}
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_an(Hash)
    end
  end

  describe 'GET show' do
    it 'renders the details of a terms policy as JSON' do
      privacy = create(:privacy_and_legal_policy)
      
      get :show, params: { id: privacy.id, token: @token }
      
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data).to be_a(Hash)
      expect(response_data['data']['attributes']['title']).to eq(privacy.title)
      expect(response_data['data']['attributes']['content']).to eq(privacy.content)
    end
  end

end
