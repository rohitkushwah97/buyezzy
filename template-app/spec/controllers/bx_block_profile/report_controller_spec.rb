require 'rails_helper'

RSpec.describe BxBlockProfile::ReportController, type: :controller do
  let!(:valid_account) { FactoryBot.create(:account) }
  let(:created_by) { FactoryBot.create(:account, activated: true) }
  let(:token) do
    BuilderJsonWebToken::JsonWebToken.encode(valid_account.id)
  end
  let(:created_for) { FactoryBot.create(:intern_user, activated: true) }
  let!(:report) { create(:report, created_by: created_by, created_for: created_for) }
  let(:token) { get_token(valid_account) }
  let(:business_user) { FactoryBot.create(:business_user) }  
  let(:country) { create(:country) }
  let(:city) { create(:city, country: country) }
  let(:industry) { create(:industry) }
  let(:work_location) { create(:work_location) }
  let(:work_schedule) { create(:work_schedule) }
  let(:educational_status) { FactoryBot.create(:educational_status, name: "High school", code: "SCH")}
  let(:version) { FactoryBot.create(:version) }

  let(:internship) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today+2.days,
      end_date: Date.today + 3.days, 
      industry_id: industry.id, 
      role_id: version.survey.role_id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status.id], 
      business_user_id: business_user.id,
      status:0
    )
  end

  before do
    request.headers['token'] = token
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { created_for_id: created_for.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end

    it 'returns the reports in descending order' do
      # get :index
      get :index, params: { created_for_id: created_for.id }
      reports = JSON.parse(response.body)
      expect(reports['data'].first['id']).to eq(report.id.to_s)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        report: {
          title: 'Inappropriate content',
          description: 'This content is inappropriate.',
        },
        created_for_id: created_for.id
      }
    end

    let(:valid_params_internship) do
      {
        report: {
          title: 'Inappropriate content',
          description: 'This content is inappropriate.',
        },
        internship_id: internship.id
      }
    end

    let(:invalid_params) do
      {
        report: { title: '' }, # Invalid title
      }
    end


    let(:invalid_params_both) do
      {
        report: {
          title: '',
          description: '',
        },
        internship_id: internship.id,
        created_for_id: created_for.id

      }
    end

    context 'with valid params' do
      it 'creates a new report for user' do
        expect {
          post :create, params: valid_params
        }.to change(BxBlockProfile::Report, :count).by(1)
      end

      it 'creates a new report for internship' do
        expect {
          post :create, params: valid_params_internship
        }.to change(BxBlockProfile::Report, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new report' do
        expect {
          post :create, params: invalid_params
        }.to_not change(BxBlockProfile::Report, :count)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors'][0]).to eq('Account or Internship not found with given ID')
      end

       it 'when internship and account both present' do
        post :create, params: invalid_params_both
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).to eq(["Title can't be blank", "Title  is not a valid report title", "Only one of internship or account must be present."])
      end
    end
  end

  describe 'GET #show' do
    it 'returns the requested report' do
      get :show, params: { id: report.id }
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data['data']['id']).to eq(report.id.to_s)
    end

    it 'returns a 404 if report is not found' do
      get :show, params: { id: 'nonexistent_id' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the report' do
      expect {
        delete :destroy, params: { id: report.id }
      }.to change(BxBlockProfile::Report, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: report.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Report deleted successfully')
    end

    it 'returns an error if report cannot be deleted' do
      allow_any_instance_of(BxBlockProfile::Report).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: report.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
