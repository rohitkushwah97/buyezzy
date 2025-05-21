require 'rails_helper'
 
RSpec.describe Admin::CountriesController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end
  let!(:country) {FactoryBot.create(:country, name: "india")}
  let(:valid_params) do
    { 
      Country: {
        name: "Pakistan" 
      } 
    }
  end
  let(:update_params) do
    { 
      id: country.id,
      Country: {
        name: "Dubai"
      } 
    }
  end

   describe "Country #Create" do
    context "create " do 
      it "should have http success for create" do 
      post :create, params: valid_params
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Country #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Country #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: country.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Country #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("Country was successfully updated.")
    end
  end
end