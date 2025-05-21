require 'rails_helper'
 
RSpec.describe Admin::UniversitiesController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end
  let!(:educational_status) { FactoryBot.create(:educational_status, name: "Unversity", code: "UNI")}
  let!(:university) { FactoryBot.create(:university) }
  let(:valid_params) do
    { 
      university: {  
        name: "Ideal international university indore" 
      } 
    }
  end
  let(:update_params) do
    { 
      id: university.id, 
      university: { 
        name: "Advanced academy indore"
      } 
    }
  end
 
  describe "University #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "University #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: university.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "University #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("University was successfully updated.")
    end
  end
end