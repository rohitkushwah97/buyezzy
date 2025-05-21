require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe Admin::CatalogueRecommendsController, type: :controller do
 
  render_views
  before(:each) do
    admin =  FactoryBot.create(:admin)
    @catalogue_recommend = FactoryBot.create(:catalogue_recommend)
    sign_in admin
  end

  describe 'GET#show' do
    it 'show data' do
      get :show, params: {id: @catalogue_recommend.id}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end

  describe 'GET#edit' do
    it 'edit data' do
      get :edit, params: {id: @catalogue_recommend.id}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end

  describe "PUT #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: { id: @catalogue_recommend.id, catalogue_recommend: { recommendation_setting: "College" } }
      expect(flash[:notice]).to eq("Catalogue recommend was successfully updated.")
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