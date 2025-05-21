require 'rails_helper'
 
RSpec.describe Admin::InternUsersController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    @intern_user = FactoryBot.create(:intern_user)
    profile =  FactoryBot.create(:profile, account_id: @intern_user.id)
    sign_in admin
  end

  TEXT = 'text/csv'

  let(:update_params) do
    { 
      id: @intern_user.id, 
      intern_user: { 
        email: "new@email.com"
      } 
    }
  end

  let(:valid_params) do
    { 
      intern_user: {  
        email: "intern@yopmail.com",
        password: "Password@1234", 
        date_of_birth: Date.today-18.years
      } 
    }
  end
 
  describe "InternUser #create" do
    it "sets flash[:notice] after create" do
      post :create, params: valid_params
      expect(flash[:notice]).to eq("Intern user was successfully created.")
    end
  end
 
  describe "InternUser #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "InternUser #show" do
    context "GET show" do 
      it "should have http success for show" do 
      get :show,params: { id: @intern_user.id}
        expect(response).to have_http_status(200)
         expect(response.body).to be_present
      end
    end
  end
 
  describe "InternUser #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit,params: { id: @intern_user.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "InternUser #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("Intern user was successfully updated.")
    end
  end
 
  describe "InternUser #destroy" do
    it "sets a flash[:notice] message after destroying the intern_user" do
      delete :destroy,params: { id: @intern_user.id }  
      expect(flash[:notice]).to eq("Intern user was successfully destroyed.") 
    end
  end

  describe "GET #index" do
    it "shows all business users" do
      get :index
      expect(response).to have_http_status(200)
      expect(response.body).to include(@intern_user.email)
    end
  end

  describe "GET #upload_csv" do
    it "renders the CSV upload form" do
      get :upload_csv
      expect(response).to render_template('account_block/intern_users/_intern_csv_upload')
    end
  end

  describe "POST #import_csv" do
    let(:valid_file) { fixture_file_upload('spec/fixtures/files/intern_user.csv', TEXT) }
    let(:invalid_file) { fixture_file_upload('spec/fixtures/files/invalid_intern_user.csv', TEXT) }

    context "with a valid CSV file" do
      it "imports business users from CSV" do
        post :import_csv, params: { csv_file: valid_file }
        expect(response).to redirect_to(admin_intern_users_path)
      end
    end

    context "without CSV file" do
      it "CSV file not present" do
        post :import_csv
        expect(response.message).to eq("Found")
      end
    end
  end

  describe "GET #download_template" do
    it "sends the template CSV file" do
      get :download_template
      expect(response).to have_http_status(:success)
      expect(response.header['Content-Type']).to include TEXT
    end
  end

  describe "Block business user" do
    it "intern user user is blocked by admin" do
      put :block_unblock_intern_user, params: { id: @intern_user.id }
      expect(flash[:notice]).to eql("Intern User blocked successfully.")
      expect(response).to redirect_to(admin_intern_users_path)
    end
  end
end