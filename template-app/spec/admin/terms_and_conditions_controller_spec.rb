require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::TermsAndConditionsController, type: :controller do
  render_views
  before(:each) do
    admin =  FactoryBot.create(:admin)
    @term_and_condition = FactoryBot.create(:term_and_condition)
    sign_in admin
  end

  describe 'GET#edit' do
    it 'edit data' do
      get :edit, params: {id: @term_and_condition.id}
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