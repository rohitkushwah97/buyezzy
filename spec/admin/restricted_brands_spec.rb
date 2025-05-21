require 'rails_helper'

RSpec.describe Admin::RestrictedBrandRequestsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @brand = create(:brand)
    @account = FactoryBot.create(:account, user_type: "seller")
    @restricted_brands = create_list(:restricted_brand, 2, brand: @brand, seller: @account)
    @approved = "No"
    @dow_doc = "Download Document"
    @brand_id = "Brand ##{@brand.id}"
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@brand_id)
      expect(response.body).to include(@approved)
      expect(response.body).to include(@dow_doc)
    end

    context 'with filters' do
      it 'filters by brand' do
        get :index, params: { q: { brand_id_eq: @brand.id } }
        expect(response.body).to include(@brand_id)
      end

      it 'filters by approved' do
        get :index, params: { q: { approved_eq: @restricted_brands.first.approved } }
        expect(response.body).to include(@approved)
      end
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: @restricted_brands.first.id }
      expect(response).to render_template(:show)
      expect(response.body).to include(@brand.id.to_s)
      expect(response.body).to include(@approved)
      expect(response.body).to include(@dow_doc)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
