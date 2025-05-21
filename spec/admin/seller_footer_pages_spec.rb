require 'rails_helper'

RSpec.describe Admin::SellerFooterPagesController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @seller_static_pages = create_list(:seller_static_page, 2, section: 'footer') 
  end

  describe 'GET index footer' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@seller_static_pages.first.title)
      expect(response.body).to include(@seller_static_pages.first.content)
      expect(response.body).to include(@seller_static_pages.first.section)
      expect(response.body).to include('No')
    end 
  end

  describe 'GET show footer' do
    it 'renders the show template' do
      get :show, params: { id: @seller_static_pages.first.id }
      expect(response).to render_template(:show)
      expect(assigns(:seller_footer_pages)).to eq(@seller_static_pages.first)
    end

    it 'renders fulfillment by partner page' do
      get :show, params: { id: @seller_static_pages.last.id }

      expect(assigns(:seller_footer_pages).title).to eq(@seller_static_pages.last.title)
    end
  end

  describe 'GET edit footer' do
    it 'renders the edit template' do
      get :edit, params: { id: @seller_static_pages.last.id }
      expect(response).to render_template(:edit)
    end
  end

end
