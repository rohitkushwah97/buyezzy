require 'rails_helper'

RSpec.describe BxBlockSurveys::QuestionsController, type: :controller do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:business_user) { FactoryBot.create(:business_user, activated: true) }
  let(:intern_token) { get_token(intern_user) }
  let(:business_token) { get_token(business_user) }
  let(:version) { FactoryBot.create(:version) }
  let!(:question) { FactoryBot.create(:question,version_id:version.id,survey_id:version.survey_id) }
  let(:body) { JSON.parse(response.body) }
  
  describe 'GET #index' do

    it 'returns intern_user question' do
      BxBlockSurveys::Survey.order(id: :asc).limit(BxBlockSurveys::Survey.count-1).delete_all
      get :index, params: { role_id:version.survey.role.id ,token: intern_token}
      expect(response).to have_http_status 200
      expect(body['role_id'].to_i).to eq(version.survey.role.id)
    end

    it 'returns intern_user question' do
      BxBlockSurveys::Survey.order(id: :asc).limit(BxBlockSurveys::Survey.count-1).delete_all
      get :index, params: { role_id:version.survey.role.id ,token: business_token}
      expect(response).to have_http_status 200
      expect(body['role_id'].to_i).to eq(version.survey.role.id)
    end

    it 'role_id is not present' do
      get :index, params: {role_id:version.survey.role.id, token: business_token}
      expect(body['data']).to eq([])
      expect(response).to have_http_status 404
    end
  end
end