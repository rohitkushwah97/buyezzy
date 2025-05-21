require 'rails_helper'

RSpec.describe Admin::SupportContactsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @supports = create_list(:support, 2) 
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@supports.first.first_name)
      expect(response.body).to include(@supports.first.last_name)
    end 
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: @supports.last.id }
      expect(response).to render_template(:show)
      expect(assigns(:support_contacts)).to eq(@supports.last)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

end
