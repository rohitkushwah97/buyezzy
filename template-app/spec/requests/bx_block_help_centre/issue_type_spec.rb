require 'rails_helper'

RSpec.describe BxBlockHelpCentre::IssueTypesController, type: :controller do
  describe 'GET #index' do
    NAME1 = 'Technical Issue'
    NAME2 = 'Billing Issue'
    before do
      BxBlockHelpCentre::IssueType.create(name: NAME1)
      BxBlockHelpCentre::IssueType.create(name: NAME2)
    end

    it 'returns a success response' do
      get :index
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(2)
      expect(json_response[0]['name']).to eq(NAME1)
      expect(json_response[1]['name']).to eq(NAME2)
    end

    it 'skips token authentication' do
      expect(controller).not_to receive(:validate_json_web_token)
      expect(controller).not_to receive(:authenticate_account)
      get :index
    end
  end
end
