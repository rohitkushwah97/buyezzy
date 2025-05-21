require 'rails_helper'

RSpec.describe Admin::StoresController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @store = create(:store)
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      
      get :show, params: { id: @store.id }
      expect(response).to render_template(:show)
      expect(response.body).to include(@store.store_name)
      expect(response.body).to include(@store.store_year.to_s)
      expect(response.body).to include(@store.store_url)
      expect(response.body).to include(@store.website_social_url)
      expect(response.body).to include(@store.brand_trade_certificate.filename.to_s) if @store.brand_trade_certificate.attached?
      expect(response.body).to include("Yes")
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'Filters' do
    it 'filters by store_name' do
      get :index, params: { q: { store_name_eq: @store.store_name } }
      expect(assigns(:stores)).to include(@store)
    end

    it 'filters by store_year' do
      get :index, params: { q: { store_year_eq: @store.store_year } }
      expect(assigns(:stores)).to include(@store)
    end

    it 'filters by store_url' do
      get :index, params: { q: { store_url_eq: @store.store_url } }
      expect(assigns(:stores)).to include(@store)
    end

    it 'filters by website_social_url' do
      get :index, params: { q: { website_social_url_eq: @store.website_social_url } }
      expect(assigns(:stores)).to include(@store)
    end

    it 'filters by approve' do
      get :index, params: { q: { approve_eq: @store.approve } }
      expect(assigns(:stores)).to include(@store)
    end

    it 'filters by created_at' do
      get :index, params: { q: { created_at_gteq_datetime: @store.created_at.strftime('%Y-%m-%d 00:00:00'), created_at_lteq_datetime: @store.created_at.strftime('%Y-%m-%d 23:59:59') } }
      expect(assigns(:stores)).to include(@store)
    end

    it 'filters by updated_at' do
      get :index, params: { q: { updated_at_gteq_datetime: @store.updated_at.strftime('%Y-%m-%d 00:00:00'), updated_at_lteq_datetime: @store.updated_at.strftime('%Y-%m-%d 23:59:59') } }
      expect(assigns(:stores)).to include(@store)
    end
  end

  # describe 'POST create' do
  #   it 'creates a new store' do
  #     brand = FactoryBot.create(:brand)
  #     post :create, params: { store: { brand_id: brand.id, store_name: 'Test Store', store_year: 2023, store_url: 'http://teststore.com', website_social_url: 'http://social.teststore.com', approve: true } }
  #     expect(response).to have_http_status(:ok)
  #     expect(BxBlockStoreManagement::Store.first.store_name).to eq('Test Store')
  #   end

    # it 'renders errors if creation fails' do
    #   post :create, params: { store: { brand_id: nil, store_name: 'Test Store', store_year: 2023, store_url: 'http://teststore.com', website_social_url: 'http://social.teststore.com', approve: true } }
    #   expect(response).to have_http_status(:unprocessable_entity)
    #   expect(json_response['errors']).to include("Brand must exist")
    # end
  # end

end
