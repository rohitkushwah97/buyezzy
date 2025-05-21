require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::PrivacyPoliciesController, type: :controller do
  render_views
  before(:each) do
    admin =  FactoryBot.create(:admin)
    @privacy_policy = FactoryBot.create(:privacy_policy)
    sign_in admin
  end

  describe 'GET#edit' do
    it 'edit data' do
      get :edit, params: {id: @privacy_policy.id}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end

  describe 'GET#index' do
    it 'shows all data' do
      get :index 
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end
  
end