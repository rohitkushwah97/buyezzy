require 'rails_helper'

RSpec.describe Admin::SellerHeaderPagesController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @seller_static_pages = create_list(:seller_static_page, 2) 
  end

  describe 'GET index header' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@seller_static_pages.first.title)
      expect(response.body).to include(@seller_static_pages.first.content)
      expect(response.body).to include(@seller_static_pages.first.section)
      expect(response.body).to include('No')
    end 
  end

  describe 'GET show header' do
    it 'renders the show template' do
      get :show, params: { id: @seller_static_pages.last.id }
      expect(response).to render_template(:show)
      expect(assigns(:seller_header_pages)).to eq(@seller_static_pages.last)
    end
  end

  describe 'GET edit header' do
    it 'renders the edit template' do
      get :edit, params: { id: @seller_static_pages.last.id }
      expect(response).to render_template(:edit)
    end
  end

end
