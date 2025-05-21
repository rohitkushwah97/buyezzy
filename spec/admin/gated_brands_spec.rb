require 'rails_helper'

RSpec.describe Admin::GatedBrandsReqsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @brand = create(:brand, gated: true)
    @gated_brand = create(:gated_brand, brand: @brand)
    @approved = "No"
    @brand_id = "Brand ##{@brand.id}"
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@brand_id)
      expect(response.body).to include(@approved)
    end

    context 'with filters' do
      it 'filters by brand' do
        get :index, params: { q: { brand_id_eq: @brand.id } }
        expect(response.body).to include(@brand_id)
      end

      it 'filters by approved' do
        get :index, params: { q: { approved_eq: @gated_brand.approved } }
        expect(response.body).to include(@approved)
      end
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: @gated_brand.id }
      expect(response).to render_template(:show)
      expect(response.body).to include(@brand_id)
      expect(response.body).to include(@approved)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
