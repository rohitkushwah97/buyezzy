require 'rails_helper'

RSpec.describe Admin::FooterStaticPagesController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @static_pages = create_list(:static_page, 2) 
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@static_pages.first.title)
      expect(response.body).to include(@static_pages.first.content)
    end 
  end

  describe 'GET show' do

    it 'renders the show template' do
      get :show, params: { id: @static_pages.last.id }
      expect(response).to render_template(:show)
      expect(assigns(:footer_static_pages)).to eq(@static_pages.last)
    end
    
  end

  describe 'GET edit' do

    it 'renders the edit template' do
      get :edit, params: { id: @static_pages.last.id }
      expect(response).to render_template(:edit)
    end
    
  end

end
