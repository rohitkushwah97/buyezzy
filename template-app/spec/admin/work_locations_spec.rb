require 'rails_helper'
 
RSpec.describe Admin::WorkLocationsController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end
  let!(:work_location) { FactoryBot.create(:work_location, icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'part_time.png'), 'image/png')) }
  let!(:work_location2) { FactoryBot.create(:work_location, name: "full_time") }
  
  let(:update_params) do
    { 
      id: work_location.id, 
      work_location: { 
        name: "time"
      } 
    }
  end

  describe 'GET#show' do
    it 'show data' do
      get :show, params: {id: work_location}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end

    it 'show data' do
      get :show, params: {id: work_location2}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end
 
  describe "Work Location #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Work Location #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: work_location.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Work Location #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("Work location was successfully updated.")
    end
  end
end