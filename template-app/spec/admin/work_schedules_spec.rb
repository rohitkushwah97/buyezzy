require 'rails_helper'
 
RSpec.describe Admin::WorkSchedulesController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end
  let!(:work_schedule) { FactoryBot.create(:work_schedule, icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'part_time.png'), 'image/png')) }
  let!(:work_schedule2) { FactoryBot.create(:work_schedule, schedule: "in_person") }
  
  let(:update_params) do
    { 
      id: work_schedule.id, 
      work_schedule: { 
        schedule: "hybrid"
      } 
    }
  end

  describe 'GET#show' do
    it 'show data' do
      get :show, params: {id: work_schedule}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 

    it 'show data' do
      get :show, params: {id: work_schedule2}
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end 
  end
 
  describe "Work Schedule #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Work Schedule #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: work_schedule.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Work Schedule #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("Work schedule was successfully updated.")
    end
  end
end