require 'rails_helper'

RSpec.describe BxBlockProfile::InternProfilesController, type: :controller do
  
  describe 'GET #show' do
    let(:intern_user) do
      AccountBlock::InternUser.create!(
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@example.com",
        password: "StrongP@ssw0rd",
        date_of_birth: Date.new(2000, 1, 1),
        full_phone_number: "+911234567890",
      )
    end

    before do
      allow(controller).to receive(:validate_json_web_token).and_return(true)
      allow(controller).to receive(:authenticate_account).and_return(true)
      allow(controller).to receive(:intern?).and_return(true)
    end

    it 'returns the correct contact background' do
      get :show, params: { id: intern_user.id }
      json_response = JSON.parse(response.body)

      expect(json_response['contact_background']['full_name']).to eq("John Doe")
      expect(json_response['contact_background']['email']).to eq("john.doe@example.com")
      expect(json_response['contact_background']['contact_number']).to eq(1234567890)
    end

    it 'returns career interests' do
      industry = BxBlockCategories::Industry.create!(name: "Tech")
      role = BxBlockCategories::Role.create!(name: "Developer", industry: industry)
      career_interest = intern_user.career_interests.create!(industry: industry, role: role)
    
      get :show, params: { id: intern_user.id }
      json_response = JSON.parse(response.body)
    
      expect(json_response['career_interests'].first['industry']).to eq("Tech")
      expect(json_response['career_interests'].first['role']).to eq("Developer")
    end    
  end
  describe 'GET #get_intern_user_generic_question' do
    let(:intern_user) do
      AccountBlock::InternUser.create!(
        first_name: "Jane",
        last_name: "Smith",
        email: "jane.smith@example.com",
        password: "StrongP@ssw0rd",
        date_of_birth: Date.new(2000, 1, 1),
        phone_number: "0987654321"
      )
    end

    # Create the required associated records
    let(:industry) { create(:industry) }
    let(:role) { create(:role) }
    let(:work_location) { create(:work_location) }
    let(:work_schedule) { create(:work_schedule) }
    let(:country) { create(:country) }
    let(:city) { create(:city) }
    let(:educational_status) { create(:educational_status) }
    let(:business_user) { create(:business_user) }

    let(:internship) do
      BxBlockNavmenu::Internship.create!(
        title: "Software Engineering Internship",
        description: "Learn and grow as a software engineer.",
        start_date: Date.today,
        end_date: Date.today + 3.months,
        deadline_date: Date.today + 7.days,
        monthly_salary: 2000,
        industry: industry,
        role: role,
        work_location: work_location,
        work_schedule: work_schedule,
        country: country,
        city: city,
        educational_statuses: [educational_status.id],
        business_user: business_user
      )
    end

    before do
      allow(controller).to receive(:validate_json_web_token).and_return(true)
      allow(controller).to receive(:authenticate_account).and_return(true)
      allow(controller).to receive(:intern?).and_return(true)
    end

    context 'when internship_id is missing' do
      it 'returns status 422 Unprocessable Entity with message "Internship ID is required."' do
        get :get_intern_user_generic_question, params: { id: intern_user.id }
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Internship ID is required.')
      end
    end

    context 'when internship is not found' do
      it 'returns status 404 Not Found with message "Internship not found."' do
        get :get_intern_user_generic_question, params: { id: intern_user.id, internship_id: 999 }
        expect(response).to have_http_status(:not_found)

        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Internship not found.')
      end
    end
    context 'when no answers are found for the intern' do
      it 'returns status 404 Not Found with message "No answers found for this intern."' do
        get :get_intern_user_generic_question, params: { id: intern_user.id, internship_id: internship.id }
        expect(response).to have_http_status(:not_found)

        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('No questions found for this internship.')
      end
    end
  end
end



