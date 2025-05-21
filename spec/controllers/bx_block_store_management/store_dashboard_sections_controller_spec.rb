require 'rails_helper'

RSpec.describe BxBlockStoreManagement::StoreDashboardSectionsController, type: :controller do

  before(:all) do
    @account = create(:account, user_type: 'seller')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @store = create(:store)
    @store_dashboard_section_banner = create(:store_dashboard_section, store: @store, section_name: 'banner', section_type: '', banner_name: "iphone")
    @store_dashboard_section = create(:store_dashboard_section, store: @store, section_name: 'section_1', section_type: '1_grid_layout')
    @store_section_grid = create(:store_section_grid, store: @store, grid_name: 'iphone', grid_no: 'grid_1', store_dashboard_section: @store_dashboard_section)

  end  

  let(:valid_attributes) {
    {
      token: @token,
      store_id: @store.id,
      section_name: 'section_2',
      section_type: '2_grids_layout',
      store_section_grids_attributes: [
        { grid_name: 'oneplus', grid_no: 'grid_2' }
      ]
    }
  }

  let(:invalid_attributes) {
    {
      token: @token,
      store_id: @store.id,
      section_name: '',
      section_type: 'invalid_type'
    }
  }

  describe "GET #index" do
    it "returns a success response index" do
      get :index, params: {store_id: @store.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns a success response show" do
      get :show, params: {store_id: @store.id, id: @store_dashboard_section_banner.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("banner_image")
      expect(JSON.parse(response.body)["data"]["attributes"]['banner_url']).to eq("www.example.com")
    end
  end

  describe "POST #create" do
    context "with valid params create" do

      it "renders a JSON response with the new store_dashboard_section" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["data"]["attributes"]["section_type"]).to eq(@store.store_dashboard_sections.last.section_type)
      end
    end

    context "with invalid params create" do
      it "renders a JSON response with errors for the new store_dashboard_section" do
        post :create, params: invalid_attributes 
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Section name can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params update" do
      let(:new_attributes) {
        {
          token: @token,
          store_id: @store.id,
          id: @store_dashboard_section.id, 
          store_section_grids_attributes: [
            { id: @store_section_grid.id, grid_name: 'oneplus update' }
          ]
        }
      }

      it "updates the requested store_dashboard_section" do
        put :update, params: new_attributes
        @store_section_grid.reload
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["attributes"]["store_section_grids"][0]["data"]["attributes"]["grid_name"]).to eq(@store_section_grid.grid_name)
      end
    end

    context "with invalid params update" do
      it "update renders a JSON response with errors for the store_dashboard_section" do
        put :update, params: invalid_attributes.merge(id: @store_dashboard_section.id)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Section name is not included in the list")
      end
    end
  end

  describe "DELETE #destroy" do
    it "delete renders a JSON response with the store_dashboard_section" do
      delete :destroy, params: {token: @token, store_id: @store_dashboard_section.store_id, id: @store_dashboard_section.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Section removed")
    end
  end
end
