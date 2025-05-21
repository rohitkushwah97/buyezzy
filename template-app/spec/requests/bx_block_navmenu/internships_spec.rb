require 'rails_helper'

RSpec.describe BxBlockNavmenu::InternshipsController, type: :request do
  let(:country) { create(:country) }
  let(:city) { create(:city, country: country) }
  let(:industry) { create(:industry) }
  let!(:role) { create(:role) }
  let(:industry1) { create(:industry) }
  let(:role1) { create(:role) }
  let(:work_location) { create(:work_location) }
  let(:work_schedule) { create(:work_schedule) }
  let!(:educational_status) { FactoryBot.create(:educational_status, name: "High school", code: "SCH")}
  let!(:educational_status2) { FactoryBot.create(:educational_status, name: "university", code: "UNI")}
  let(:business_user) { FactoryBot.create(:business_user) }
  let(:business_user_applyed) { FactoryBot.create(:business_user) }
  let!(:company_detail) { FactoryBot.create(:company_detail, business_user: business_user, company_name: "witmates")}
  let!(:company_detail_2) { FactoryBot.create(:company_detail, business_user: business_user_applyed, company_name: "witmates2")}
  let(:token) { BuilderJsonWebToken::JsonWebToken.encode(business_user.id) }
  let!(:intern_user) { FactoryBot.create(:intern_user, email: "intern_user@yopmail.com") }
  let!(:intern_user2) { FactoryBot.create(:intern_user) }
  let(:intern_token) { BuilderJsonWebToken::JsonWebToken.encode(intern_user.id) }
  let(:intern_token2) { BuilderJsonWebToken::JsonWebToken.encode(intern_user2.id) }
  let!(:career_interest) { FactoryBot.create(:career_interest, intern_user_id: intern_user.id, role_id: role.id)  }
  let!(:school_education) { FactoryBot.create(:school_education, intern_user_id: intern_user.id, educational_status_id: educational_status.id) }
  let!(:university_education) { FactoryBot.create(:university_education, intern_user_id: intern_user2.id, educational_status_id: educational_status2.id) }

  let(:headers) do
    {
      'token' => token,
    }
  end

  let(:intern_headers) do
    {
      'token' => intern_token,
    }
  end
  let(:intern_headers2) do
    {
      'token' => intern_token2,
    }
  end

  let(:active_url) {'/bx_block_navmenu/internships/get_active_internships'}

  let!(:internship) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today+2.days,
      end_date: Date.today + 3.days, 
      deadline_date: Date.today + 7.days,
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status.id], 
      business_user_id: business_user.id
    )
  end 

  let!(:internship2) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today,
      end_date: Date.today + 8.days, 
      deadline_date: Date.today + 7.days,
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status2.id], 
      business_user_id: business_user.id,
      status: "active"
    )
  end

  let!(:internship_applyed) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today,
      end_date: Date.today + 8.days, 
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status2.id], 
      business_user_id: business_user_applyed.id,
      status: "active"
    )
  end

  let!(:internship3) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today,
      end_date: Date.today + 3.days, 
      deadline_date: Date.today + 7.days,
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [school_education.educational_status.id], 
      business_user_id: business_user.id,
      status: "active"
    )
  end

  let!(:internship4) do
    create(:bx_block_navmenu_internship,
      title: "internship title",
      start_date: Date.today,
      end_date: Date.today + 3.days, 
      deadline_date: Date.today + 7.days,
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status.id], 
      business_user_id: business_user.id,
      status: "active"
    )
  end

  let!(:internship5) do
    create(:bx_block_navmenu_internship,
      title: "internship title",
      start_date: Date.today,
      end_date: Date.today + 3.days, 
      deadline_date: Date.today + 7.days,
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status2.id], 
      business_user_id: business_user.id,
      status: "active"
    )
  end 

  let(:valid_params) do
    {
      internship: {
        start_date: Date.today,
        end_date: Date.today + 5.days,
        deadline_date: Date.today + 7.days,
        title: "Internship Title",
        description: "Internship Description",
        monthly_salary: 1000,
        industry_id: industry1.id,
        role_id: role1.id,
        work_location_id: work_location.id,
        work_schedule_id: work_schedule.id,
        country_id: country.id,
        city_id: city.id,
        educational_statuses: [educational_status.id]
      }
    }
  end

  let(:invalid_params) do
    {
      internship: {
        start_date: nil,
        end_date: nil, 
        deadline_date: nil,
        title: '',       
        description: '', 
        monthly_salary: -1000, 
        industry_id: nil,
        role_id: nil,
        work_location_id: nil,
        work_schedule_id: nil,
        country_id: nil,
        city_id: nil,
        educational_statuses: []
      }
    }
  end

  let!(:user_survey) { intern_user.user_surveys.create(role_id: internship2.role.id, quiz_status: "completed", version_id: 2) }
  let!(:user_survey2) { intern_user2.user_surveys.create(role_id: internship5.role.id, quiz_status: "completed", version_id: 2) }
  let!(:user_survey3) { internship5.create_user_survey!(account_id: business_user.id, role_id: internship5.role.id, quiz_status: "completed", version_id: 2) }

  describe 'POST /bx_block_navmenu/internships/index_internhsips' do
    url = '/bx_block_navmenu/internships/index_internhsips'

    it 'returns all internships without filter' do
      post url, headers: headers
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(response.body).to be_present
      expect(res["data"].count).to eql(5)
      expect(res["data"][0]["attributes"]["applied"]).to eql(false)
    end

    it 'returns all internships with work_location_id filter' do
      post url,params:{work_location_id:[internship.work_location_id]}, headers: headers
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(response.body).to be_present
      expect(res['data'][0]['attributes']['work_location_id']).to eql(internship.work_location_id)
    end

    it 'returns all internships with work_schedule_id filter' do
      post url,params:{work_schedule_id:[internship.work_schedule_id]}, headers: headers
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(response.body).to be_present
      expect(res['data'][0]['attributes']['work_schedule_id']).to eql(internship.work_schedule_id)
    end

    it 'returns all internships with country_id filter' do
      post url,params:{country_id:internship.country_id}, headers: headers
      res = json_response
      expect(response).to have_http_status(:ok)
      # expect(res["data"][0]["id"].to_i).to eql(internship.id)
      expect(res['data'][0]['attributes']['country_id']).to eql(internship.country_id)
    end

    it 'returns all internships with city_id filter' do
      post url,params:{city_id: internship.city_id}, headers: headers
      res = json_response
      expect(response).to have_http_status(:ok)
      # expect(res["data"][0]["id"].to_i).to eql(internship.id)
      expect(res['data'][0]['attributes']['city_id']).to eql(internship.city_id)
    end

    it 'returns all internships with search filter' do
      post url,params:{search:internship.title}, headers: headers
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res["data"][0]["id"].to_i).to eql(internship.id)
      expect(res['data'][0]['attributes']['title']).to eql(internship.title)
    end
  end

  describe 'POST #get active internships' do
    it 'returns a list of active internships1' do
      post active_url, headers: intern_headers, params: {search: 'internship'}
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res['data']).to be_present
    end

    it 'returns a pagination internships' do
      post active_url, headers: intern_headers, params: {page: 1 ,per_page: 2}
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res['data']).to be_present
      expect(res['meta']['pagination']['per_page']).to be_present
      expect(res['meta']['pagination']['current_page']).to be_present
      expect(res['meta']['pagination']['total_count']).to be_present
      expect(res['meta']['pagination']['total_pages']).to be_present
    end

     it 'returns a list of active internships2' do
      post active_url, headers: intern_headers2, params: {search: 'interns'}
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res["data"][0]["attributes"]["title"]).to eql(internship4.title)
    end

    it 'returns a list of active internships3' do
      internship2.destroy
      post active_url, headers: intern_headers, params: {work_location_id: [work_location.id], work_schedule_id: [work_schedule.id], match_type: ["Good match","Outstanding match"], duration: "less than equals to one month"}
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res).not_to be_empty
    end

    it 'returns a list of active internships three months or less' do
      internship2.destroy
      post active_url, headers: intern_headers, params: {work_location_id: [work_location.id], work_schedule_id: [work_schedule.id], match_type: ["Good match","Outstanding match"], duration: "less than equals to three months"}
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res).not_to be_empty
    end

    it 'returns a list of active internships six month or less' do
      internship2.destroy
      post active_url, headers: intern_headers, params: {work_location_id: [work_location.id], work_schedule_id: [work_schedule.id], match_type: ["Good match","Outstanding match"], duration: "less than equals to six months"}
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res).not_to be_empty
    end

    it 'returns a list of active internships more than six months' do
      internship2.destroy
      post active_url, headers: intern_headers, params: {work_location_id: [work_location.id], work_schedule_id: [work_schedule.id], match_type: ["Good match","Outstanding match"], duration: "more than six months"}
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res).not_to be_empty
    end

    it 'returns a empty list of active internships' do
      post active_url, headers: intern_headers
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res).not_to be_empty
    end

    it 'returns internships with a future deadline' do
      post active_url, headers: intern_headers
      res = json_response
      expect(res).not_to be_empty
    end

    context 'Internship visibility with block logic' do 
      let!(:current_user) { create(:account) }
      let!(:blocked_user) { create(:account, type: "BusinessUser") }
      let!(:blocking_user) { create(:account, type: "BusinessUser") }
      let!(:neutral_user) { create(:account, type: "BusinessUser") }

      let!(:internship_blocked_user) { create(:bx_block_navmenu_internship, business_user_id: blocked_user.id) }
      let!(:internship_blocking_user) { create(:bx_block_navmenu_internship, business_user_id: blocking_user.id) }
      let!(:internship_from_neutral_user) { create(:bx_block_navmenu_internship, business_user_id: neutral_user.id) }
      before do
        # current_user has blocked blocked_user
        BxBlockBlockUsers::BlockUser.create!(
          account_id: current_user.id,
          current_user_id: blocked_user.id
        )

        # blocking_user has blocked current_user
        BxBlockBlockUsers::BlockUser.create!(
          account_id: blocking_user.id,
          current_user_id: current_user.id
        )
      end

      it 'returns internships excluding blocked and blocking users' do
        post active_url, headers: intern_headers
        json = JSON.parse(response.body)
        returned_ids = json["data"].map { |i| i["id"] }
        expect(returned_ids).not_to include(internship_blocked_user.id)
        expect(returned_ids).not_to include(internship_blocking_user.id)
      end
    end
  end

  describe 'GET #get apply internships' do
    it 'return successfully applied message' do
      get "/bx_block_navmenu/internships/#{internship2.id}/get_apply_internship", headers: intern_headers
      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res["message"]).to eq("Internship applied successfully.")
    end

    it 'should return error when career interests not match with role' do
      get "/bx_block_navmenu/internships/#{internship3.id}/get_apply_internship", headers: intern_headers2
      res = json_response
      expect(response).to have_http_status(401)
      expect(res["message"]).to eq("To apply for this internship, you’ll need to add this role to your career interests and complete the quiz first.")
      expect(res["code"]).to eq("add role")
    end

    it 'should return error when version is not match' do
      intern_user2.career_interests.create(role_id: internship3.role.id, industry_id: industry.id)
      get "/bx_block_navmenu/internships/#{internship3.id}/get_apply_internship", headers: intern_headers2
      res = json_response
      expect(response).to have_http_status(401)
      expect(res["message"]).to eq("Version of answers given by users is not same. You cannot apply for the job.")
      expect(res["code"]).to eq("version not match")
    end
    

    it 'raise error when internship has been already applied' do
      intern_user.internships << internship
      get "/bx_block_navmenu/internships/#{internship.id}/get_apply_internship", headers: intern_headers
      res = json_response
      expect(res["message"]).to eq("Already applied.")
    end

    it 'raise error when internship is not found' do
      get "/bx_block_navmenu/internships/10000/get_apply_internship", headers: intern_headers
      res = json_response
      expect(response).to have_http_status(404)
      expect(res["errors"]).to include("Record not found")
    end
  end

  describe 'GET # get apply internship' do
    before do 
      intern_user.user_surveys.find_by(role_id: internship2.role.id).update_column(:version_id, 2)
    end
    it 'should return version match validation' do
      get "/bx_block_navmenu/internships/#{internship2.id}/get_apply_internship", headers: intern_headers
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["message"]).to eq("Internship applied successfully.")
    end
  end


  describe 'GET /bx_block_navmenu/internships/:id' do
    context 'when internship exists' do
      it 'returns the internship' do
        get "/bx_block_navmenu/internships/#{internship.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(json_response['data']['id']).to eq(internship.id.to_s)
      end

      it ' internships returns' do
        get "/bx_block_navmenu/internships/#{internship3.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(json_response).to be_present
      end
    end

    context 'when internship not exists' do
      it 'raise record not found error' do
        get "/bx_block_navmenu/internships/123456", headers: headers
        expect(response).to have_http_status(:not_found)
        expect(json_response['errors']).not_to be_empty
      end
    end

  end

  describe 'DELETE /bx_block_navmenu/internships/:id' do
    it 'deletes the internship' do
      internship 
      expect {
        delete "/bx_block_navmenu/internships/#{internship.id}", headers: headers
      }.to change(BxBlockNavmenu::Internship, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(json_response['message']).to eq('Internship deleted.')
    end
  end

  describe 'PUT /bx_block_navmenu/internships/:id' do
    context 'with valid parameters' do
      it 'updates the internship and returns the updated internship' do
        put "/bx_block_navmenu/internships/#{internship.id}", params: valid_params, headers: headers

        expect(response).to have_http_status(:ok)
        expect(json_response['data']['attributes']['title']).to eq("Internship Title")
        expect(json_response['data']['attributes']['monthly_salary']).to eq("1000.0")
      end
    end

    context 'with invalid params' do
      it 'return error response' do
        put "/bx_block_navmenu/internships/#{internship.id}", params: invalid_params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).not_to be_empty
      end
    end
  end

  describe 'POST /bx_block_navmenu/internships/' do
    context 'when user has not created an internship' do
      it 'creates an internship and returns a success response' do
        BxBlockNavmenu::Internship.destroy_all
        post '/bx_block_navmenu/internships/', params: valid_params, headers: headers
        expect(response).to have_http_status(:ok)
        expect(json_response['data']['attributes']['title']).to eq("Internship Title")
        expect(json_response['data']['attributes']['monthly_salary']).to eq("1000.0")
      end
    end

    context 'when internship parameters are invalid' do
      it 'returns an error response' do 
        internship2.destroy
        internship3.destroy 
        post '/bx_block_navmenu/internships/', params: invalid_params, headers: headers
  
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).not_to be_empty
      end
    end

    context 'when user creating internship while having active internship' do
      it ' response' do
        internship.update(status: "active")
        post '/bx_block_navmenu/internships/', params: valid_params, headers: headers 
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response["errors"]).to eq("There can be only one active internship at-a-time. So Internship cannot be created.")
      end
    end
  end

  describe 'PUT /bx_block_navmenu/internships/:id/publish' do
    context 'with valid data' do
      it 'publish the internship successfully' do
        business_user.internships.active.update(status:0)
        internship.user_survey.update(quiz_status: "completed")
        put "/bx_block_navmenu/internships/#{internship.id}/publish", headers: headers
        expect(response).to have_http_status(:ok)
        expect(json_response['message']).to eq("Your internship listing is live.")
      end
    end

    context 'Retake quiz when versions change' do
      it 'should raise an versions validations error' do
        internship.user_survey.update(retake: true, quiz_status: "completed")
        put "/bx_block_navmenu/internships/#{internship.id}/publish", headers: headers
        expect(response).to have_http_status(401)
        expect(json_response['message']).to eq("Please Retake quiz to Publish.")
      end
    end

    context 'should raise validation error' do
      it 'return error response when user_survey is pending' do
        put "/bx_block_navmenu/internships/#{internship.id}/publish", headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).to eq("It looks like some mandatory items are missing")
      end

      it 'return error response when start date is paased away' do
        internship.user_survey.update(quiz_status: "completed")
        internship.update(start_date: Date.yesterday)
        put "/bx_block_navmenu/internships/#{internship.id}/publish", headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).to eq("Internship date has passed away")
      end
    end

    describe 'GET #get_all_applicants' do
      applicants_url = '/bx_block_navmenu/internships/get_all_applicants'
      before do
        business_user.internships.active.limit(3).update(status:2)
        internship5.accounts << intern_user
        internship5.accounts << intern_user2
      end

      it 'returns all applicants based on the filter and search criteria' do
        post applicants_url , headers: headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res["data"][0]["attributes"]).to be_present
      end

      it 'returns all applicants based on the filter and match_type criteria' do
        match_type = 'Good match'
        intern_user.recommendations.create(internship_id:internship5.id, match_type: match_type)
        post applicants_url ,params:{filter:{match: [match_type]}}, headers: headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res["data"][0]["attributes"]['internships']['match_type']).to eql(match_type)  
      end

      it 'returns all applicants based on the filter and country_id criteria' do
        country_id = intern_user.profile.country_id
        post applicants_url ,params:{filter:{country_id: country_id}}, headers: headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res["data"][0]["attributes"]['internships']['country_id']).to eql(country_id)  
      end

       it 'returns all applicants based on the filter and city_id criteria' do
        city_id = intern_user.profile.city_id
        post applicants_url ,params:{filter:{city_id: city_id}}, headers: headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res["data"][0]["attributes"]['internships']['city_id']).to eql(city_id)  
      end

      it 'internship is not active' do
        business_user.internships.active.update(status:2)
        post applicants_url , headers: headers
        res = json_response
        expect(response).to have_http_status(:not_found)
        expect(res["data"]).to eql([])
      end

      it 'returns a pagination on applicants' do
        post applicants_url, headers: headers, params: {page: 1 ,per_page: 2}
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['meta']['pagination']['per_page']).to be_present
        expect(res['meta']['pagination']['current_page']).to be_present
        expect(res['meta']['pagination']['total_count']).to be_present
        expect(res['meta']['pagination']['total_pages']).to be_present
      end
    end

    describe 'GET #get_internships_by_filter' do
      let!(:work_location) { FactoryBot.create(:work_location, name: "Abcd") }
      let!(:work_schedule) { FactoryBot.create(:work_schedule, schedule: 'School') }
      let!(:city) {FactoryBot.create(:city)}
      let!(:country) {FactoryBot.create(:country)}
      INTERNSHIP_URL = '/bx_block_navmenu/internships/get_applied_internships'

      it 'returns all applicants based on the search criteria' do
        get '/bx_block_navmenu/internships/get_internships_by_filter', 
            params: { 
              work_location_id: work_location.id,
              work_schedule_id: work_schedule.id,
              country_id: country.id,
              city: city.id
            }, headers: intern_headers

        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res["data"][1]["attributes"]["status"]).to eql("active")
      end
    end

    describe 'GET #get applied internships' do
      it 'returns applied internships' do
        post INTERNSHIP_URL, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res["data"]).to eql([])
      end
    end

    describe 'GET #get_applied_internships' do

      before do
        intern_user.internships << internship
      end

      it 'returns applied internships of intern user' do
        post INTERNSHIP_URL, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
      end

      it 'search applied internships with title' do
        post INTERNSHIP_URL,params: {search: internship.title}, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['title']).to eq(internship.title)
      end

      it 'search applied internships with company name' do
        company_name = internship.business_user.company_detail.company_name
        post INTERNSHIP_URL,params: {search: company_name}, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['title']).to eq(internship.title)
      end

      it 'apply work_location_id filter on internships' do
        post INTERNSHIP_URL,params: { filter: { work_location_id: [ internship.work_location_id ]} }, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['work_location_id']).to eq(internship.work_location_id)
      end

      it 'apply work_schedule_id filter on internships' do
        post INTERNSHIP_URL,params: { filter: { work_schedule_id: [ internship.work_schedule_id ]} }, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['role_id']).to eq(internship.role_id)
      end

      it 'apply role_id filter on internships' do
        post INTERNSHIP_URL,params: { filter: { role_id: [ internship.role_id ]} }, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['role_id']).to eq(internship.role_id)
      end

      it 'apply country_id filter on internships' do
        post INTERNSHIP_URL,params: { filter: { country_id: [ internship.country_id ]} }, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['country_id']).to eq(internship.country_id)
      end

      it 'apply city_id filter on internships' do
        post INTERNSHIP_URL,params: { filter: { city_id: [ internship.city_id ]} }, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['city_id']).to eq(internship.city_id)
      end

      it 'apply start_date filter on internships' do
        post INTERNSHIP_URL,params: { filter: { start_date: [ internship.start_date ]} }, headers: intern_headers
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data'][0]['attributes']['id']).to eq(internship.id)
        expect(res['data'][0]['attributes']['start_date']).to eq(internship.start_date.strftime("%Y-%m-%d"))
      end

      it 'returns a pagination on applied internships' do
        post INTERNSHIP_URL, headers: intern_headers, params: {page: 1 ,per_page: 1}
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res['data']).to be_present
        expect(res['meta']['pagination']['per_page']).to be_present
        expect(res['meta']['pagination']['current_page']).to be_present
        expect(res['meta']['pagination']['total_count']).to be_present
        expect(res['meta']['pagination']['total_pages']).to be_present
      end
    end
  end

  describe 'GET #review_job_postings' do
    it 'returns review_job_postings' do
      get '/bx_block_navmenu/internships/review_job_posting', params: {id: internship.id}, headers: headers
      res = json_response
      pending = 'Pending'
      expect(res['data']['attributes']['internship_details']).to eq('Completed')
      expect(res['data']['attributes']['industry_quiz']).to eq('Pending')
      expect(res['data']['attributes']['intern_characteristic']).to eq(pending)
      expect(res['data']['attributes']['extra_questions']).to eq(pending)
      expect(res['data']['attributes']['job_description']).to eq('Pending')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #withdraw' do
    context "when internship start date is in the future" do
      let!(:internship) { create(:bx_block_navmenu_internship, deadline_date: Date.today + 7.days, start_date: Date.tomorrow) }
      let!(:account_internship) { create(:accounts_bx_block_navmenu_internships, account_id: intern_user.id, internship_id: internship.id) }

      it "updates status to withdraw" do
        put "/bx_block_navmenu/internships/#{internship.id}/withdraw", headers: intern_headers
        expect(JSON.parse(response.body)["message"]).to eq("Internship withdrawn successfully.")
      end
    end

    context "when internship has already started" do
      let(:internship) { create(:bx_block_navmenu_internship, deadline_date: Date.today + 7.days, start_date: Date.today - 1.day) }
      let!(:account_internship) { create(:accounts_bx_block_navmenu_internships, account_id: intern_user.id, internship_id: internship.id) }

      it "does not allow withdrawal" do
        put "/bx_block_navmenu/internships/#{internship.id}/withdraw", params: { id: internship.id }, headers: intern_headers

        expect(JSON.parse(response.body)["message"]).to eq("Cannot withdraw after internship start date.")
      end
    end
  end

  describe 'PUT #terminate' do
    context "when internship start date is today or in the past" do
      let!(:internship) do
        create(:bx_block_navmenu_internship, deadline_date: Date.today + 7.days, start_date: Date.today - 3.days, status: "active")
      end
      let!(:account_internship) { create(:accounts_bx_block_navmenu_internships, account_id: intern_user.id, internship_id: internship.id) }

      it "terminates the internship successfully" do
        put "/bx_block_navmenu/internships/#{internship.id}/terminate", headers: intern_headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("You have successfully terminate the internship.")
      end
    end

    context "when internship start date is in the future" do
      let!(:internship) do
        create(:bx_block_navmenu_internship, deadline_date: Date.today + 7.days, start_date: Date.today + 2.days, status: "active")
      end
      let!(:account_internship) { create(:accounts_bx_block_navmenu_internships, account_id: intern_user.id, internship_id: internship.id) }

      it "does not allow termination" do
        put "/bx_block_navmenu/internships/#{internship.id}/terminate", headers: intern_headers
        expect(JSON.parse(response.body)["message"]).to eq("Cannot terminate before internship start date.")
      end
    end
  end

  describe 'PUT /bx_block_navmenu/internships/update_applicant_status' do

    before do
      internship.update!(status: "active")
    end
    let(:url) { '/bx_block_navmenu/internships/update_applicant_status' }
    let!(:account_internship) do
      BxBlockNavmenu::AccountInternship.create!(
        account_id: intern_user.id,
        internship_id: internship.id,
        status: "pending"
      )
    end

    it 'updates the applicant status successfully' do
      put url,
        params: { 
          internship_id: internship.id, 
          intern_id: intern_user.id, 
          status: 'offered' 
        },
        headers: headers

      res = json_response
      expect(response).to have_http_status(:ok)
      expect(res["message"]).to eq("Status updated successfully")
      expect(res["data"]["status"]).to eq("offered")
    end

    it 'returns error if internship not found' do
      put url,
        params: { 
          internship_id: 0, # Wrong ID
          intern_id: intern_user.id, 
          status: 'offered' 
        },
        headers: headers

      res = json_response
      expect(response).to have_http_status(:not_found)
      expect(res["error"]).to eq("Internship not found")
    end

    it 'returns error if applicant not found' do
      put url,
        params: { 
          internship_id: internship.id,
          intern_id: 0, # Wrong intern id
          status: 'offered'
        },
        headers: headers

      res = json_response
      expect(response).to have_http_status(:not_found)
      expect(res["error"]).to eq("Applicant not found")
    end

    it 'returns error if application not found' do
      put url,
        params: { 
          internship_id: internship2.id, # Different internship
          intern_id: intern_user.id,
          status: 'offered'
        },
        headers: headers

      res = json_response
      expect(response).to have_http_status(:not_found)
      expect(res["error"]).to eq("Application not found")
    end
  end

  describe "GET /bx_block_navmenu/internships/applicants_by_given_status" do
    let!(:account_internship) do
      BxBlockNavmenu::AccountInternship.create!(
        account_id: intern_user.id,
        internship_id: internship2.id,
        status: :rejected
      )
    end

    let!(:account_internship2) do
      BxBlockNavmenu::AccountInternship.create!(
        account_id: intern_user2.id,
        internship_id: internship2.id,
        status: :offered
      )
    end

    let(:endpoint) { "/bx_block_navmenu/internships/applicants_by_given_status" }

    context "when valid status is passed" do
      it "returns applicants with given status" do
        get endpoint, params: { status: "rejected" }, headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["data"]).to be_present
        expect(json["data"].first["id"]).to eq(intern_user.id.to_s)
      end
    end

    context "when invalid status is passed" do
      it "returns error" do
        get endpoint, params: { status: "invalid_status" }, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Invalid status")
      end
    end

    context "when there is no active internship" do
      before do
        business_user.internships.update_all(status: "draft")
      end

      it "returns not found" do
        get endpoint, params: { status: "rejected" }, headers: headers

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)
        expect(json["message"]).to eq("No active internship found")
      end
    end
  end

  describe "GET /bx_block_navmenu/internships/applied_internships" do

    let!(:account_internship1) do
      BxBlockNavmenu::AccountInternship.create!(
        account_id: intern_user.id,
        internship_id: internship2.id,
        status: :offered
      )
    end

    let!(:account_internship2) do
      BxBlockNavmenu::AccountInternship.create!(
        account_id: intern_user.id,
        internship_id: internship_applyed.id,
        status: :interview_requested
      )
    end

    let!(:offer) do
      BxBlockSurveys::MakeOffer.create!(
        internship_id: internship2.id,
        intern_user_id: intern_user.id,
        business_user_id: business_user.id,
        offer_status: :accepted,
        number_of_days: 3
      )
    end

    let!(:interview_request) do
      BxBlockRequestManagement::RequestInterview.create!(
        internship_id: internship_applyed.id,
        intern_user_id: intern_user.id,
        business_user_id: business_user_applyed.id,
        number_of_days: 3,
        status: :pending
      )
    end

    let(:endpoint) { "/bx_block_navmenu/internships/applied_internships" }

    it "returns all internships applied by the intern user with application_info" do
      get endpoint, headers: intern_headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      data = json["data"]

      expect(data.count).to eq(2)

      internship_response_1 = data.find { |d| d["id"] == internship2.id.to_s }
      internship_response_2 = data.find { |d| d["id"] == internship_applyed.id.to_s }

      expect(internship_response_1["attributes"]["application_info"]["application_status"]).to eq("offered")
      expect(internship_response_1["attributes"]["application_info"]["offer_status"]).to eq("accepted")

      expect(internship_response_2["attributes"]["application_info"]["application_status"]).to eq("interview_requested")
      expect(internship_response_2["attributes"]["application_info"]["request_status"]).to eq("pending")
    end
  end

  describe 'POST #closed_internship' do
    context 'when offers are pending' do
      before do
        @offer = BxBlockSurveys::MakeOffer.create!(
          internship_id: internship.id,
          intern_user_id: intern_user.id,
          business_user_id: business_user.id,
          number_of_days: 3
        )
      end

      it 'returns error due to pending offers' do
        put "/bx_block_navmenu/internships/#{internship.id}/closed_internship", headers: headers
        expect(JSON.parse(response.body)['errors']).to eq('your internship cannot closed as offers is pending.')
      end
    end

    context 'when offers responded' do
      before do
        @offer = BxBlockSurveys::MakeOffer.create!(
          internship_id: internship.id,
          intern_user_id: intern_user.id,
          business_user_id: business_user.id,
          offer_status: :accepted,
          number_of_days: 3
        )
      end

      it 'closes internship successfully' do
        put "/bx_block_navmenu/internships/#{internship.id}/closed_internship", headers: headers
        expect(JSON.parse(response.body)['message']).to eq('Internship has been closed successfully.')
      end
    end
  end

  describe 'GET #get_applied_internships for intern user' do

      let!(:account_internship1) do
        BxBlockNavmenu::AccountInternship.create!(
          account_id: intern_user.id,
          internship_id: internship2.id,
          status: :offered
        )
      end

      let!(:account_internship2) do
        BxBlockNavmenu::AccountInternship.create!(
          account_id: intern_user.id,
          internship_id: internship_applyed.id,
          status: :interview_requested
        )
      end

      let!(:offer) do
        BxBlockSurveys::MakeOffer.create!(
          internship_id: internship2.id,
          intern_user_id: intern_user.id,
          business_user_id: business_user.id,
          offer_status: :accepted,
          number_of_days: 3
        )
      end

      let!(:interview_request) do
        BxBlockRequestManagement::RequestInterview.create!(
          internship_id: internship_applyed.id,
          intern_user_id: intern_user.id,
          business_user_id: business_user_applyed.id,
          number_of_days: 3,
          status: :pending
        )
      end

      it "returns all internships applied by the intern user with application_info old api" do
        post "/bx_block_navmenu/internships/get_applied_internships", headers: intern_headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        data = json["data"]

        expect(data.count).to eq(4)

        internship_response_1 = data.find { |d| d["id"] == internship2.id.to_s }
        internship_response_2 = data.find { |d| d["id"] == internship_applyed.id.to_s }
        expect(internship_response_1["attributes"]["application_status"]["status"]).to eq("offered")
        expect(internship_response_1["attributes"]["application_status"]["offer_status"]).to eq("accepted")

        expect(internship_response_2["attributes"]["application_status"]["status"]).to eq("interview_requested")
        expect(internship_response_2["attributes"]["application_status"]["interview_status"]).to eq("pending")
      end
  end

  describe 'GET #get_applied_internships for intern user' do

      let(:request_url) { "/bx_block_navmenu/internships/get_status_wise_applied_internships" }

      let!(:account_internship1) do
        BxBlockNavmenu::AccountInternship.create!(
          account_id: intern_user.id,
          internship_id: internship2.id,
          status: :offered
        )
      end

      let!(:account_internship2) do
        BxBlockNavmenu::AccountInternship.create!(
          account_id: intern_user.id,
          internship_id: internship_applyed.id,
          status: :interview_requested
        )
      end

      let!(:offer) do
        BxBlockSurveys::MakeOffer.create!(
          internship_id: internship2.id,
          intern_user_id: intern_user.id,
          business_user_id: business_user.id,
          offer_status: :accepted,
          number_of_days: 3
        )
      end

      let!(:interview_request) do
        BxBlockRequestManagement::RequestInterview.create!(
          internship_id: internship_applyed.id,
          intern_user_id: intern_user.id,
          business_user_id: business_user_applyed.id,
          number_of_days: 3,
          status: :pending
        )
      end

      it "returns all internships applied by the intern user with application_info old api" do
        get request_url, headers: intern_headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        data = json["data"]

        expect(data.count).to eq(4)

        internship_response_1 = data.find { |d| d["id"] == internship2.id.to_s }
        internship_response_2 = data.find { |d| d["id"] == internship_applyed.id.to_s }
        expect(internship_response_1["attributes"]["application_status"]["status"]).to eq("offered")
        expect(internship_response_1["attributes"]["application_status"]["offer_status"]).to eq("accepted")

        expect(internship_response_2["attributes"]["application_status"]["status"]).to eq("interview_requested")
        expect(internship_response_2["attributes"]["application_status"]["interview_status"]).to eq("pending")
      end

      context "with status filter" do
      it "returns only offered internships when status is offered" do
        get request_url, 
            headers: intern_headers, params: { status: 'offered' }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        data = json["data"]

        expect(data.count).to eq(2)
        expect(data.first["attributes"]["application_status"]["status"]).to eq("offered")
        expect(data.first["attributes"]["application_status"]["number_of_days"]).to eq(3)
      end

      it "returns only interview_requested internships when status is interview_requested" do
        get request_url, 
            headers: intern_headers, params: { status: 'interview_requested' }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        data = json["data"]

        expect(data.count).to eq(2)
        expect(data.first["attributes"]["application_status"]["status"]).to eq("interview_requested")
        expect(data.first["attributes"]["application_status"]["number_of_days"]).to eq(3)
      end
    end

    context "with search term" do
      it "returns filtered internships by title or company name" do
        internship2.update(title: "Marketing Intern")
        get request_url, 
            headers: intern_headers, params: { search: "marketing" }

        json = JSON.parse(response.body)
        expect(json["data"].count).to eq(2)
        expect(json["data"].first["type"]).to eq("internship")
        expect(json["data"].first["attributes"]["title"]).to eq("Marketing Intern")
      end
    end

    it "returns bad request when status is invalid" do
      get request_url, 
          headers: intern_headers, params: { status: 'invalid_status' }

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)
      expect(json["errors"]).to include("Invalid status")
    end
  end
end
