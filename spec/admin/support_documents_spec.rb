require 'rails_helper'

RSpec.describe Admin::SupportDocumentsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @support_document = create(:support_document)
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@support_document.page_title)
      expect(response.body).to include(@support_document.content)
    end
  end

  describe 'GET edit' do
    it 'renders the edit template' do
      get :edit, params: { id: @support_document.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: @support_document.id }
      expect(response).to render_template(:show)
    end

    it 'displays the page title and content' do
      get :show, params: { id: @support_document.id }
      expect(response.body).to include(@support_document.page_title)
      expect(response.body).to include(@support_document.content)
    end
  end

end
