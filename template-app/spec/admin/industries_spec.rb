require 'rails_helper'
 
RSpec.describe Admin::IndustriesController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:industry) { FactoryBot.create(:industry) }
  let(:valid_params) do
    { 
      industry: {  
        name: "Information Technology",
      } 
    }
  end
  let(:update_params) do
    { 
      id: industry.id, 
      industry: { 
        name: "Medical"
      } 
    }
  end

 
  # describe "Industry #create" do
  #   it "sets flash[:notice] after create" do
  #     post :create, params: valid_params
  #     expect(flash[:notice]).to eq("Industry was successfully created.")
  #   end
  # end

  describe "Industry #create more records" do
    let!(:industries) { FactoryBot.create_list(:industry, 20) }
    it "sets flash[:message] after create when more records" do
      post :create, params: valid_params
      expect(flash[:message]).to eq("Cannot add more than 20 industries")
    end
  end
 
  describe "Industry #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Industry #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit, params: { id: industry.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Industry #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("Industry was successfully updated.")
    end
  end

  describe "Industry #destroy" do
    it "sets flash[:error] industry not deleted" do
      role = FactoryBot.create(:role,industry_id:industry.id)
      FactoryBot.create(:bx_block_navmenu_internship,role_id:role.id, industry_id:industry.id,status:1)
      delete :destroy, params: {id: industry.id}
      expect(flash[:error]).to eq("Industry cannot be deleted because it has active internships")
    end
  end

   describe "Industry #batch_action" do
    it "delete all Industry" do
      post :batch_action, params: {collection_selection:[industry.id],batch_action: 'destroy'}
      expect(flash[:notice]).to eq("Selected industry were successfully deleted.")
    end

    it "if any Industry have active intership" do
      role = FactoryBot.create(:role,industry_id:industry.id)
      FactoryBot.create(:bx_block_navmenu_internship,role_id:role.id, industry_id:industry.id,status:1)
      post :batch_action, params: {collection_selection:[industry.id],batch_action: 'destroy'}
      expect(flash[:error]).to eq("The following industry were not deleted because they have active internships: #{industry.name}")
    end
  end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    