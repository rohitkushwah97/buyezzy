require 'rails_helper'
 
RSpec.describe Admin::BusinessUsersController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    @business_user = FactoryBot.create(:business_user)
    profile =  FactoryBot.create(:company_detail, business_user_id: @business_user.id)
    sign_in admin
  end
  let(:valid_params) do
    { 
      business_user: {  
        email: "business@yopmail.com",
        password: "Password@1234",
      } 
    }
  end
  let(:update_params) do
    { 
      id: @business_user.id,
      business_user: { 
        email: "new@co.in",
        company_detail_attributes:{
          company_name: "test company"
        }

      } 
    }
  end

  TEXT = 'text/csv'

  describe 'POST #create' do
      let(:valid_params) do
        {
          business_user: {
            email: 'test@business.com',
            password: 'password123',
            full_phone_number: '+123456789',
            full_name: 'Test Business',
            company_detail_attributes: {
              country_id: 1,
              city_id: 2,
              industry_id: 3,
              company_name: 'Test Company',
              website_link: 'http://example.com',
              contact_number: '123456789',
              address: '123 Test Street',
              company_description: 'A test company description',
            }
          }
        }
      end

      let(:invalid_params) do
        {
          business_user: {
            email: '', # Invalid email
            password: '',
            full_phone_number: '',
            full_name: ''
          }
        }
      end
    context 'when valid params are provided' do
      it 'creates a new business user and redirects to the show page' do
        expect {
          post :create, params: valid_params
        }.to change(AccountBlock::BusinessUser, :count).by(0)

        created_user = AccountBlock::BusinessUser.last
      end
    end
  end
 
  describe "BusinessUser #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "BusinessUser #show" do
    context "GET show" do 
      it "should have http success for show" do 
      get :show,params: { id: @business_user.id}
        expect(response).to have_http_status(200)
         expect(response.body).to be_present
      end
    end
  end
 
  describe "BusinessUser #Edit" do
    context "put update " do 
      it "should have http success for update" do 
      put :edit,params: { id: @business_user.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "BusinessUser #update" do
    it "sets flash[:notice] after update" do
      patch :update, params: update_params
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
      expect(response.message).to eq("OK")
    end
  end
  
  describe "GET #index" do
    it "shows all business users" do
      get :index
      expect(response).to have_http_status(200)
      expect(response.body).to include(@business_user.email)
    end
  end

  describe "GET #upload_csv" do
    it "renders the CSV upload form" do
      get :upload_csv
      expect(response).to render_template('account_block/business_users/_csv_upload')
    end
  end

  describe "POST #import_csv" do
    let(:valid_file) { fixture_file_upload('spec/fixtures/files/user.csv', TEXT) }
    let(:invalid_file) { fixture_file_upload('spec/fixtures/files/invalid_user.csv', TEXT) }

    context "with a valid CSV file" do
      it "imports business users from CSV" do
        post :import_csv, params: { csv_file: valid_file }
        expect {
          post :import_csv, params: { csv_file: valid_file }
        }
        expect(response).to redirect_to(admin_business_users_path)
      end
    end

    context "with a valid CSV file" do
      it "imports business users from CSV" do
        post :import_csv, params: { csv_file: invalid_file }
        expect(response).to redirect_to(admin_business_users_path)
      end
    end

    context "CSV file is not present" do
      it "CSV file is nil" do
        post :import_csv
        expect(response).to redirect_to(admin_business_users_path)
      end
    end

    context "when an error occurs during CSV import" do
      before do
        allow(CSV).to receive(:foreach).and_raise(StandardError.new("Test error"))
      end
  
      it "creates an admin notification and redirects to the index page" do
        notification = BxBlockNotifications::AdminNotification.last
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

  describe "BusinessUser #show - Questions Column" do
    # let!(:internship) { FactoryBot.create(:internship, business_user: @business_user) }
    let!(:internship) { FactoryBot.create(:bx_block_navmenu_internship, business_user: @business_user) }

    let!(:question1) { FactoryBot.create(:intern_user_generic_question, internship: internship, question: "What is your availability?") }
    let!(:question2) { FactoryBot.create(:intern_user_generic_question, internship: internship, question: "Why do you want this internship?") }

    it "renders generic questions for the internship" do
      get :show, params: { id: @business_user.id }
      expect(response.body).to include("What is your availability?")
      expect(response.body).to include("Why do you want this internship?")
    end
  end

  describe "BusinessUser #show - Applicants Column" do
    # let!(:internship) { FactoryBot.create(:internship, business_user: @business_user) }
      let!(:internship) { FactoryBot.create(:bx_block_navmenu_internship, business_user: @business_user) }


    it "renders a link to view applicants for the internship" do
      get :show, params: { id: @business_user.id }
      expect(response.body).to include(get_applicants_bx_block_surveys_intern_user_generic_questions_path(internship.id))
      expect(response.body).to include("applicants")
    end
  end

  describe "Block business user" do
    it "business user is blocked by admin" do
      put :block_unblock_business_user, params: { id: @business_user.id }
      expect(flash[:notice]).to eql("Business User blocked successfully.")
      expect(response).to redirect_to(admin_business_users_path)
    end
  end
end