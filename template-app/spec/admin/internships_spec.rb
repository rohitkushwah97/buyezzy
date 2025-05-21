require 'rails_helper'

RSpec.describe Admin::InternshipsController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:country) { create(:country) }
  let!(:city) { create(:city, country: country) }
  let!(:industry) { create(:industry) }
  let!(:role) { create(:role) }
  let!(:work_location) { create(:work_location) }
  let!(:work_schedule) { create(:work_schedule) }
  let!(:educational_status) { create(:educational_status) }
  let!(:business_user) { create(:business_user, email: 'business@example.com') }
  let!(:intern_user) { create(:intern_user, email: 'intern@example.com') }
  let!(:internship) do
    create(:bx_block_navmenu_internship, 
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
  let!(:apply) { internship.accounts << intern_user }

  describe 'GET #index' do
    it 'displays internships' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(internship.title)
    end
  end

  describe 'GET #applicants' do
    it 'returns all applicants of internship' do
      get :applicants, params: { id: internship.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(internship.title)
    end
  end

  describe 'GET #show' do
  it 'displays internships' do
    get :show, params: { id: internship.id }
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(internship.title)
    
  end
end

end
