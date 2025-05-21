require 'rails_helper'

RSpec.describe Admin::BrandsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @brands = create_list(:brand, 2) 
    @brand_c = create(:brand)
    @catalogue = create(:catalogue, brand: @brand_c)
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@brands.first.brand_name)
      expect(response.body).to include(@brands.first.brand_year.to_s)
      expect(response.body).to include(@brands.first.approve.to_s)
      expect(response.body).to include(@brands.first.restricted.to_s)
      expect(response.body).to include(@brands.first.gated.to_s)
      expect(response.body).to include(@brands.first.created_at.strftime('%B %d, %Y %H:%M'))
      expect(response.body).to include(@brands.first.updated_at.strftime('%B %d, %Y %H:%M'))
    end

    context 'with filters' do
      it 'filters by brand name' do
        get :index, params: { q: { brand_name_cont: @brands.first.brand_name } }
        expect(assigns(:brands)).to include(@brands.first)
      end

      it 'filters by brand year' do
        get :index, params: { q: { brand_year_eq: @brands.first.brand_year } }
        expect(assigns(:brands)).to include(@brands.first)
      end

      it 'filters by brand website' do
        get :index, params: { q: { brand_website_cont: @brands.first.brand_website } }
        expect(assigns(:brands)).to include(@brands.first)
      end

      it 'filters by approve' do
        get :index, params: { q: { approve_eq: @brands.first.approve } }
        expect(assigns(:brands)).to include(@brands.first)
      end

      it 'filters by restricted' do
        @brands.first.update(restricted: true)
        get :index, params: { q: { approve_eq: @brands.first.restricted } }
        expect(assigns(:brands)).to include(@brands.first)
      end

      it 'filters by gated' do
        @brands.first.update(gated: true)
        get :index, params: { q: { approve_eq: @brands.first.gated } }
        expect(assigns(:brands)).to include(@brands.first)
      end

      it 'filters by created_at' do
        get :index, params: { q: { created_at_gteq: @brands.first.created_at.strftime("%Y-%m-%d 00:00:00"), created_at_lteq: @brands.first.created_at.strftime("%Y-%m-%d 23:59:59") } }
        expect(assigns(:brands)).to include(@brands.first)
      end

      it 'filters by updated_at' do
        get :index, params: { q: { updated_at_gteq: @brands.first.updated_at.strftime("%Y-%m-%d 00:00:00"), updated_at_lteq: @brands.first.updated_at.strftime("%Y-%m-%d 23:59:59") } }
        expect(assigns(:brands)).to include(@brands.first)
      end
    end

  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: @brands.first.id }
      expect(response).to render_template(:show)
      expect(response.body).to include(@brands.first.brand_name)
      expect(response.body).to include(@brands.first.brand_year.to_s)
      expect(response.body).to include(@brands.first.brand_website)
      expect(response.body).to include("Yes")
    end
  end

  describe 'PUT#update' do
    it 'update a brand' do 
      @brand_c.update(approve: false)
      @brand_c.update(approve: true)
      put :update, params: {id: @brand_c.id, approve: true}
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE destroy' do
    it 'flash error of association' do
      get :destroy, params: { id: @brand_c.id }
      expect(response).to redirect_to(admin_brands_path)
      expect(flash['alert']).to include("Cannot delete brand because it is associated with products or store.")
    end

    it 'renders notice success' do
      @catalogue.destroy
      get :destroy, params: { id: @brand_c.id }
      expect(response).to redirect_to(admin_brands_path)
      expect(flash[:notice]).to include('Brand deleted successfully.')
    end
  end
end
