require 'rails_helper'

RSpec.describe BxBlockSurveys::SubmissionsController, type: :request do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:intern_token) { get_token(intern_user) }
  let(:business_user) { create(:business_user, activated: true) }
  let(:business_token) { BuilderJsonWebToken::JsonWebToken.encode(business_user.id) }
  let(:version) { FactoryBot.create(:version) }
  let(:question) { FactoryBot.create(:question,version_id:version.id,survey_id:BxBlockSurveys::Survey.last.id) }
  let(:option) { FactoryBot.create(:option,question_id:question.id) }
  let!(:career_interest) { FactoryBot.create(:career_interest,intern_user_id:intern_user.id ) }
  let!(:internship) { FactoryBot.create(:bx_block_navmenu_internship,industry_id: career_interest.industry_id,role_id: version.survey.role_id ,business_user_id: business_user.id) }
  let(:body) { JSON.parse(response.body) }

  let(:valid_params){
    {
      answers: [
        {
          question_id: question.id,
          option_id: option.id,
          option_position: "c"
        }
      ],
      role_id: version.survey.role_id,
      internship_id: internship.id
    }
  }

  let(:invalid_params){
    {
      answers: [
        {
          question_id:question.id,
          option_id: option.id 
        }
      ],
      version_id: version.id,
      role_id: 0
    }
  }

  let(:intern_characteristic_params){
    {
      role_id: version.survey.role_id,
      internship_id: internship.id,
      intern_characteristic_importances:[
        {
          intern_characteristic_id:question.intern_characteristic.id,
          value:20
        }
      ]
    }
  }

  let(:intern_characteristic_invalid_params){
    {
      role_id: version.survey.role_id,
      internship_id: internship.id,
      intern_characteristic_importances:[
        {
          intern_characteristic_id:0,
          value:20
        }
      ]
    }
  }

  describe 'POST #create' do
    URL = '/bx_block_surveys/submissions'
    message = 'Congratulations! You are all set! You can Publish your internship now!'

    before do
      @params = valid_params
      BxBlockSurveys::Survey.order(id: :asc).limit(BxBlockSurveys::Survey.count-1).delete_all
    end

    it 'returns business_user question' do
      post URL, params: @params, headers:{token: business_token}
      internship.user_survey.submissions.first.option_value_float
      expect(response).to have_http_status 200
      expect(body['message']).to eq(message)
    end

    it 'returns answer is not given' do
      post URL, params:{version_id:version.id}, headers:{token: intern_token}
      expect(response).to have_http_status 404
      expect(body['errors']).to eq('Answers and role_id need to be present')
    end

    it 'returns user survey is not present' do
      post URL, params:invalid_params, headers:{token: intern_token}
      expect(response).to have_http_status 422
      expect(body['errors']).to eq('It looks like some mandatory items are missing.')
    end

    it 'when retake is true' do
      internship.user_survey.update(retake: true)
      post URL, params: @params, headers:{token: business_token}
      expect(response).to have_http_status 200
      expect(body['message']).to eq(message)
    end
  end

  describe 'get #index' do
    before do
      @params = valid_params
      BxBlockSurveys::Survey.order(id: :asc).limit(BxBlockSurveys::Survey.count-1).delete_all
    end

    it 'returns business_user answers' do
      post URL, params:@params, headers:{token: business_token}
      get URL, params:{role_id: version.survey.role_id,internship_id: internship.id}, headers:{token: business_token}
      expect(response).to have_http_status 200
      expect(body['data'][0]['attributes']['question']['id']).to eq(@params[:answers][0][:question_id])
    end

    it ' not returns business_user answers' do
      get URL, params:{role_id: version.survey.role_id,internship_id: internship.id}, headers:{token: intern_token}
      expect(response).to have_http_status 200
      expect(body['data']).to eq(nil)
    end
  end

  describe 'get #questions_and_answer' do
    before do
      @params = valid_params
      BxBlockSurveys::Survey.order(id: :asc).limit(BxBlockSurveys::Survey.count-1).delete_all
    end

    it 'returns questions and answers' do
      post URL, params:@params, headers:{token: business_token}
      get URL+"/questions_and_answer", params:{role_id: version.survey.role_id,intern_user_id: business_user.id}, headers:{token: business_token}
      expect(response).to have_http_status 200
      expect(body['data'][0]['attributes']['question']['id']).to eq(@params[:answers][0][:question_id])
    end
  end

  describe 'get #create_intern_characteristic_importances' do
    it 'create intern characteristic importances' do
      post URL+'/create_intern_characteristic_importances', params: intern_characteristic_params, headers:{token: business_token}
      expect(response).to have_http_status 200
      expect(body['message']).to eq('Intern Characteristic Values are submitted.')
    end

    it ' intern characteristic importances not created' do
      post URL+'/create_intern_characteristic_importances', params: intern_characteristic_invalid_params, headers:{token: business_token}
      expect(response).to have_http_status 422
      expect(body['error']).to eq('Validation failed: Intern characteristic must exist')
    end
  end
end