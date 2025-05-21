require 'rails_helper'
 
RSpec.describe Admin::SchoolsController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end
  let!(:educational_status) { FactoryBot.create(:educational_status, name: "High school", code: "SCH")}
  let!(:school) { FactoryBot.create(:school) }
  let(:valid_params) do
    { 
      school: {  
        name: "Ideal international school" 
      } 
    }
  end
  let(:update_params) do
    { 
      id: school.id, 
      school: { 
        name: "Advanced academy"
      } 
    }
  end
 
  describe "School #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "School #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: school.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "School #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("School was successfully updated.")
    end
  end
end