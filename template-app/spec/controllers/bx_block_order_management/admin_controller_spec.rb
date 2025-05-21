# spec/controllers/bx_block_order_management/admin_controller_spec.rb

require 'rails_helper'

module BxBlockOrderManagement
  RSpec.describe AdminController, type: :controller do
    let!(:activated_account) { create(:account, email: "active@gmail.com", password: "Password@123", activated: true) }
    let!(:inactive_account) { create(:account, email: "inactive@gmail.com", password: "Password@123", activated: false) }
    let(:token) { BuilderJsonWebToken::JsonWebToken.encode(activated_account.id) }

    before do
      request.headers["token"] = token
    end

    describe 'GET #get_roles' do
      context 'without industry_id' do
        it 'returns a list of all roles' do
          roles = create_list(:role, 5)
          get :get_roles
          expect(response).to have_http_status(:ok)
          expect(response.body).to include("name")
        end
      end

      context 'with industry_id' do
        it 'returns a list of roles for a specific industry' do
          industry = create(:industry)
          roles_for_industry = create_list(:role, 3, industry: industry)
          create_list(:role, 2) 
          get :get_roles, params: { industry_id: industry.id }
          expect(response).to have_http_status(:ok)
          expect(response.body).to include("name")
        end
      end
    end

    describe 'GET #get_industries' do
      it 'returns a list of industries' do
        industries = create_list(:industry, 3)
        get :get_industries
        expect(response).to have_http_status(:ok)
        expect(json_response['data'].first['type']).to eq("industry")
      end
    end

    describe 'GET #get_work_locations' do
  it 'returns a list of work locations' do
    work_locations = create_list(:work_location, 4)
    get :get_work_locations
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("code")
  end
end


    describe 'GET #get_work_schedules' do
      it 'returns a list of work schedules' do
        work_schedules = create_list(:work_schedule, 2)
        get :get_work_schedules
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("code")
      end
    end

    describe 'GET #get_countries' do
      it 'returns a list of countries' do
        countries = create_list(:country, 6)
        get :get_countries
        expect(response).to have_http_status(:ok)
        expect(json_response['data'].first['type']).to eq("country")
      end
    end

    describe 'GET #get_cities' do
      it 'returns a list of cities' do
        cities = create_list(:city, 3)
        get :get_cities
        expect(response).to have_http_status(:ok)
        expect(json_response['data'].first['type']).to eq("city")
      end
    end

    describe 'GET #type_of_interns' do
      it 'returns a list of educational statuses' do
        educational_statuses = create_list(:educational_status, 5)
        get :type_of_interns
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("name")
      end
    end
  end
end
