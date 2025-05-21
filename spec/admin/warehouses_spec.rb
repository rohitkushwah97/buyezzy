require 'rails_helper'

RSpec.describe Admin::WarehousesController, type: :controller do

  render_views
  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @warehouse1 = FactoryBot.create(:warehouse)
  end

  let(:valid_attributes) { { warehouse_type: "Test type", warehouse_name: "Warehouse name test" } }

  describe "index page" do
    it "displays a list of warehouses" do
      warehouse2 = FactoryBot.create(:warehouse, warehouse_type: "Type B", warehouse_name: "Warehouse 2")

      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to include(@warehouse1.warehouse_name)
      expect(response.body).to include(warehouse2.warehouse_name)
    end

    it "filters by warehouse_name" do
      get :index, params: { q: { warehouse_name_eq: @warehouse1.warehouse_name } }
      expect(assigns(:warehouses)).to include(@warehouse1)
    end

    it "filters by warehouse_address" do
      get :index, params: { q: { processing_days_eq: @warehouse1.processing_days } }
      expect(assigns(:warehouses)).to include(@warehouse1)
    end

    it "filters by created_at" do
      get :index, params: { q: { created_at_gteq_datetime: @warehouse1.created_at.strftime('%Y-%m-%d 00:00:00'), created_at_lteq_datetime: @warehouse1.created_at.strftime('%Y-%m-%d 23:59:59') } }
      expect(assigns(:warehouses)).to include(@warehouse1)
    end

    it "filters by updated_at" do
      get :index, params: { q: { updated_at_gteq_datetime: @warehouse1.updated_at.strftime('%Y-%m-%d 00:00:00'), updated_at_lteq_datetime: @warehouse1.updated_at.strftime('%Y-%m-%d 23:59:59') } }
      expect(assigns(:warehouses)).to include(@warehouse1)
    end
    
  end

  describe "show page" do
    it "displays the details of a warehouse" do
      get :show, params: {id: @warehouse1.id}
      expect(assigns(:warehouse)).to eq(@warehouse1)
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to have_http_status(:ok)
      expect(assigns(:warehouse)).to be_a_new(BxBlockCatalogue::Warehouse)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new warehouse" do
        expect {
          post :create, params: { warehouse: valid_attributes }
        }.to change(BxBlockCatalogue::Warehouse, :count).by(1)
        expect(response).to redirect_to(admin_warehouse_path(BxBlockCatalogue::Warehouse.last))
        expect(flash[:notice]).to eq("Warehouse was successfully created.")
      end
    end
  end

end
