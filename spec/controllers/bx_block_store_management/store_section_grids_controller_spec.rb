require 'rails_helper'

RSpec.describe BxBlockStoreManagement::StoreSectionGridsController, type: :controller do
  before(:all) do
    @account = create(:account, user_type: 'seller')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @store = create(:store)
    @store_dashboard_section = create(:store_dashboard_section, store: @store, section_name: 'section_1', section_type: '1_grid_layout')
    @store_section_grid = create(:store_section_grid, store: @store, grid_name: 'iphone', grid_no: 'grid_1', store_dashboard_section: @store_dashboard_section)

  end

  let(:valid_attributes) {
    {
      token: @token,
      store_id: @store.id,
      store_dashboard_section_id: @store_dashboard_section.id,
      grid_name: 'oneplus',
      grid_no: 'grid_2'
    }
  }

  let(:invalid_attributes) {
    {
      token: @token,
      store_id: @store.id,
      store_dashboard_section_id: @store_dashboard_section.id,
      grid_name: '',
      grid_no: 'invalid_grid'
    }
  }

  describe "GET #index" do
    it "returns a success response index" do
      get :index, params: { token: @token, store_id: @store.id, store_dashboard_section_id: @store_dashboard_section.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns a success response show" do
      get :show, params: { token: @token, store_id: @store.id, store_dashboard_section_id: @store_dashboard_section.id, id: @store_section_grid.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("grid_image")
      expect(JSON.parse(response.body)["data"]["attributes"]['grid_url']).to eq("www.example.com")
    end
  end

  describe "POST #create" do
    context "with valid params crate" do
      # it "creates a new StoreSectionGrid" do
      #   expect {
      #     post :create, params: valid_attributes
      #   }.to change(BxBlockStoreManagement::StoreSectionGrid, :count).by(1)
      # end

      it "renders a JSON response with the new store_section_grid" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["data"]["attributes"]["grid_name"]).to eq(@store_dashboard_section.store_section_grids.last.grid_name)
      end
    end

    context "with invalid params create" do
      it "renders a JSON response with errors for the new store_section_grid" do
        post :create, params: invalid_attributes 
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Grid name can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params update" do
      let(:new_attributes) {
        {
          token: @token,
          store_id: @store.id,
          store_dashboard_section_id: @store_dashboard_section.id,
          id: @store_section_grid.id, 
          grid_name: 'grid_3'
        }
      }

      it "updates the requested store_section_grid" do
        put :update, params: new_attributes
        @store_section_grid.reload
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["attributes"]["grid_name"]).to eq(@store_section_grid.grid_name)
      end
    end

    context "with invalid params update" do
      it "update renders a JSON response with errors for the store_section_grid" do
        put :update, params: invalid_attributes.merge({id: @store_section_grid.id, grid_url: "asd"})
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Grid url should start with 'https://' or 'www.'")
      end
    end
  end

  describe "DELETE #destroy" do
    # it "destroys the requested store_section_grid" do
    #   expect {
    #     delete :destroy, params: { token: @token, store_id: @store.id, store_dashboard_section_id: @store_dashboard_section.id, id: @store_section_grid.id }
    #   }.to change(BxBlockStoreManagement::StoreSectionGrid, :count).by(-1)
    # end

    it "delete renders a JSON response with the store_section_grid" do
      delete :destroy, params: { token: @token, store_id: @store.id, store_dashboard_section_id: @store_dashboard_section.id, id: @store_section_grid.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Grid removed")
    end
  end
end
