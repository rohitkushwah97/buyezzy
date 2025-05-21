require 'rails_helper'

RSpec.describe BxBlockRecommendation::InternshipRecommendationsController, type: :controller do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:university) {FactoryBot.create(:university)}
  let(:educational_status) {FactoryBot.create(:educational_status, name: "university", code: "UNI")}
  let(:intern_token) { get_token(intern_user) }
  let!(:university_education) {FactoryBot.create(:university_education, educational_status_id: educational_status.id, intern_user_id: intern_user.id, university_id: university.id)}
  let(:business_user) { create(:business_user, activated: true) }
  let(:business_token) { get_token(business_user) }
  let(:internship) { FactoryBot.create(:bx_block_navmenu_internship,business_user_id: business_user.id,status:1, educational_statuses: [educational_status.id]) }
  let!(:recommendation) {internship.recommendations.create!(intern_user_id:intern_user.id, role_id: internship.role_id, match_type: 'Outstanding match')}
  let(:body) { JSON.parse(response.body) }

  let(:filter_params) do
    {
      token: intern_token,
      filter: {
        city_id: internship.city_id,
        role_id: [internship.role_id],
        industry_id: [internship.industry_id],
        country_id: internship.country_id
      }
    }
  end


  describe "GET /get_internsips_recommendation" do
    context 'get recommendations with filter and search' do
      it 'returns internship recommendations' do
        post :get_internsips_recommendation, params:{token: intern_token}
        expect( body['data'][0]['attributes']['match_type']).to eq('Outstanding match')
        expect(response).to have_http_status 200
      end

      it 'search internship recommendations' do
        post :get_internsips_recommendation, params:{token: intern_token,search: internship.title}
        expect(body['data'][0]['attributes']['title']).to eq(internship.title)
        expect(response).to have_http_status 200
      end

      it 'filter internship recommendations' do
        post :get_internsips_recommendation, params: filter_params
        expect(body['data'][0]['attributes']['city_id']).to eq(internship.city_id)
        expect(body['data'][0]['attributes']['role_name']).to eq(internship.role.name)
        expect(body['data'][0]['attributes']['industry_name']).to eq(internship.industry.name)
        expect(body['data'][0]['attributes']['country_id']).to eq(internship.country_id)
        expect(response).to have_http_status 200
      end
    end

    it 'not returns internship recommendations' do
      internship.update(educational_statuses: [])
      post :get_internsips_recommendation, params:{token: intern_token}
      expect(body['data']).to eql([])
      expect(response).to have_http_status 200
    end

    it 'returns recommendations internships with a future deadline' do
      post :get_internsips_recommendation, params:{token: intern_token}
      res = json_response
      expect(res).not_to be_empty
    end
  end

  describe 'GET #get_recommended_applicants' do
    before do
      internship.recommendations.create!(intern_user_id: intern_user.id,match_type: "Good match")
      intern_user.internships<<internship
    end

    it 'returns recommended_applicant' do      
      get :get_recommended_applicants, params:{token: business_token}
      expect(response).to have_http_status(:ok)
      expect(body['data'][0]['id'].to_i).to eq(intern_user.id)
    end

    it 'returns search recommended_applicant' do
      get :get_recommended_applicants, params:{token: business_token,search: intern_user.full_name}
      expect(response).to have_http_status(:ok)
      expect(body['data'][0]['attributes']['full_name']).to eq(intern_user.full_name)
    end

    it 'returns search recommended_applicant' do
      get :get_recommended_applicants, params:{token: business_token,filter:{city_id: intern_user.profile.city_id}}
      expect(response).to have_http_status(:ok)
      expect(body['data'][0]['attributes']['profile']['city']['id']).to eq(intern_user.profile.city_id)
    end

    it 'when no active internhsip is present' do
      internship.update(status:2)
      get :get_recommended_applicants, params:{token: business_token}
      expect(response).to have_http_status(:not_found)
      expect(body['data']).to eql([])
    end
  end

  describe 'DELETE #destory_recommendations' do
    let(:admin_user) { FactoryBot.create(:intern_user, email: 'shivam@yopmail.com',activated: true) }
    let(:admin_token) { get_token(admin_user) }

    it 'delete recommendations' do

      delete :destory_recommendations, params:{token: admin_token}
      expect(response).to have_http_status(:ok)
      expect(body['message']).to eql('recommendations deleted')
    end
  end
end