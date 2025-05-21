require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::EducationalStatusesController, type: :controller do
  render_views
  before(:each) do
    admin =  FactoryBot.create(:admin)
    @educational_status = FactoryBot.create(:educational_status)
    sign_in admin
  end

  describe 'GET#show' do
    it 'show data' do
      get :show, params: {id: @educational_status.id}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end

  describe 'GET#edit' do
    it 'edit data' do
      get :edit, params: {id: @educational_status.id}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end

  describe "PUT #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: { id: @educational_status.id, educational_status: { name: "College" } }
      expect(flash[:notice]).to eq("Educational status was successfully updated.")
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