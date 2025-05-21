require 'rails_helper'

RSpec.describe BxBlockStoreManagement::StoreMenusController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @store = create(:store)
    @image = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg"))
    @catalogues = create_list(:catalogue, 2)
    @menu = create(:store_menu, store: @store, logo: @image, catalogues: @catalogues)
  end  

  describe 'GET index' do
    it 'returns a list of menus for a store' do
      get :index, params: { store_id: @store.id, token: @token }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET store_menus_list' do
    it 'returns a list of menus for a store without catalogue' do
      get :store_menus_list, params: { store_id: @store.id, token: @token }
      expect(JSON.parse(response.body)["store_menus"][0]['id']).to eq(@menu.id)
    end
  end

  describe 'GET show' do
    context 'when logo is attached' do
      it 'returns a menu for a store with logo URL' do
        get :show, params: { store_id: @store.id, id: @menu.id, token: @token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("logo")
      end
    end

    context 'when logo is not attached' do
      it 'returns a menu for a store without logo URL' do
        get :show, params: { store_id: @store.id, id: 999, token: @token }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Menu not found")
      end
    end
  end


  describe 'POST create' do
    it 'creates a new menu for a store' do
      BxBlockStoreManagement::StoreMenu.where(position: 6, store_id: 1).delete_all
      post :create, params: {catalogue_ids: @catalogues&.map(&:id), position: 6 ,store_id: @store.id, title: 'New Menu', token: @token, cover_image: @image }
      expect(response).to have_http_status(201)
      expect(assigns(:menu).title).to eq('New Menu')
      expect(assigns(:menu).catalogues&.map(&:id)).to match_array(@catalogues&.map(&:id))
    end

    it 'renders errors if creation fails' do
      post :create, params: { store_id: @store.id, title: nil, token: @token ,logo: @image}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Title can't be blank")
    end
  end

  describe 'PATCH update' do
    it 'updates an existing menu for a store' do
      patch :update, params: {catalogue_ids: @catalogues&.map(&:id), store_id: @store.id, id: @menu.id, title: 'Updated Menu', token: @token }
      expect(response).to have_http_status(:ok)
      expect(@menu.reload.title).to eq('Updated Menu')
      expect(@menu.catalogues&.map(&:id)).to match_array(@catalogues&.map(&:id))
    end

    it 'renders errors if update fails' do
      patch :update, params: { store_id: @store.id, id: @menu.id, title: nil, token: @token }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Title can't be blank")
    end
  end

  describe 'DELETE destroy' do
    it 'destroys a menu for a store' do
      delete :destroy, params: { store_id: @store.id, id: @menu.id , token: @token}
      expect(response).to have_http_status(200)
      expect(response.body).to include('Menu removed')
    end
  end
end
