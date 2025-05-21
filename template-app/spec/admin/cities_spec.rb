require 'rails_helper'
 
RSpec.describe Admin::CitiesController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end
  let(:country) {FactoryBot.create(:country, name: "india")}
  let!(:city) {FactoryBot.create(:city, country_id: country.id)}
  let(:valid_params) do
    { 
      City: {
        country_id: country.id, 
        name: "Indore" 
      } 
    }
  end
  let(:update_params) do
    { 
      id: city.id, 
      City: { 
        name: "Datia"
      } 
    }
  end

   describe "City #Create" do
    context "create " do 
      it "should have http success for create" do 
      post :create, params: valid_params
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "City #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "City #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: city.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "City #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("City was successfully updated.")
    end
  end
end