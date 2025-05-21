
require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::AcademicLevelsController, type: :controller do
  render_views

  before(:each) do
    admin =  FactoryBot.create(:admin)
    @academic_level = FactoryBot.create(:academic_level)
    sign_in admin
  end

	let(:valid_params) do
    { 
      academic_level: {
        name: "12th Standard" 
      } 
    }
  end

   describe "Academic Level #Create" do
    context "create " do 
      it "should have http success for create" do 
      post :create, params: valid_params
        expect(response).to have_http_status(302)
        expect(response.body).to be_present
      end
    end
  end

  describe 'GET#show' do
    it 'show data' do
      get :show, params: {id: @academic_level.id}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end

  describe 'GET#edit' do
    it 'edit data' do
      get :edit, params: {id: @academic_level.id}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end

  describe "PUT #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: { id: @academic_level.id, academic_level: { name: "11th Standard" } }
      expect(flash[:notice]).to eq("Academic level was successfully updated.")
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