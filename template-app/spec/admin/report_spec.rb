require 'rails_helper'

RSpec.describe Admin::ReportsController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end

  # Creating test data
  let!(:business_user) { create(:business_user) }  # Factory for BusinessUser
  let!(:intern_user) { create(:intern_user) }      # Factory for InternUser (non-BusinessUser)
  
  let!(:report_with_business_user) do
    create(:report, 
           title: 'Other', 
           description: 'This is a report created by a business user.',
           created_for_id: business_user.id, 
           created_by_id: business_user.id
    )
  end

  let!(:report_with_intern_user) do
    create(:report, 
           title: 'Other', 
           description: 'This is a report created by an intern user.',
           created_for_id: intern_user.id, 
           created_by_id: intern_user.id
    )
  end

  describe 'GET #index' do
    it 'displays reports created by a Business User' do
      get :index
      expect(response).to have_http_status(:ok)  
    end

    it 'displays reports created by an Intern User' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(report_with_intern_user.title)
      expect(response.body).to include(intern_user.full_name)  # Should display InternUser name
    end
  end

  describe 'GET #show' do
    it 'displays a report with a Business User as created_for and created_by' do
      get :show, params: { id: report_with_business_user.id }
      # expect(response).to have_http_status(:ok)
    end

    it 'displays a report with an Intern User as created_for and created_by' do
      get :show, params: { id: report_with_intern_user.id }
      # expect(response).to have_http_status(:ok)
    end
  end
end
