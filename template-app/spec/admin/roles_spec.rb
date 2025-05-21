require 'rails_helper'
 
RSpec.describe Admin::RolesController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end

  let(:industry) { FactoryBot.create(:industry) }
  let!(:role) { FactoryBot.create(:role) }
  let(:valid_params) do
    { 
      role: {  
        name: "Admin",
        industry_id: industry.id, 
      } 
    }
  end
  let(:update_params) do
    { 
      id: role.id, 
      role: { 
        name: "Sales"
      } 
    }
  end

 
  describe "Role #create" do
    it "sets flash[:notice] after create" do
      post :create, params: valid_params
      expect(flash[:notice]).to eq("Role was successfully created.")
    end
  end

  describe "Role #create more records" do
    let!(:roles) { FactoryBot.create_list(:role, 20, industry_id: industry.id) }
    it "sets flash[:message] after create when more records" do
      post :create, params: valid_params
      expect(flash[:message]).to eq("#{industry.name.titleize} can't have more than 20 roles.")
    end
  end
 
  describe "Role #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Role #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: role.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Role #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("Role was successfully updated.")
    end
  end

  describe "Role #destroy" do
    it "sets flash[:error] role not deleted" do
      FactoryBot.create(:bx_block_navmenu_internship,role_id:role.id, industry_id:role.industry.id,status:1)
      delete :destroy, params: {id:role.id}
      expect(flash[:error]).to eq("Role cannot be deleted because it has active internships")
    end
  end

  describe "Role #batch_action" do
    it "delete all role" do
      post :batch_action, params: {collection_selection:[role.id],batch_action: 'destroy'}
      expect(flash[:notice]).to eq("Selected roles were successfully deleted.")
    end

    it "if any role have active intership" do
      FactoryBot.create(:bx_block_navmenu_internship,role_id:role.id, industry_id:role.industry.id,status:1)
      post :batch_action, params: {collection_selection:[role.id],batch_action: 'destroy'}
      expect(flash[:error]).to eq("The following roles were not deleted because they have active internships: #{role.name}")
    end
  end
end