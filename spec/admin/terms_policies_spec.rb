require 'rails_helper'

RSpec.describe Admin::TermsAndPoliciesController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @terms_policy = create(:terms_policy)
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@terms_policy.page_title)
      expect(response.body).to include(@terms_policy.content)
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: @terms_policy.id }
      expect(response).to render_template(:show)
    end

    it 'displays the page title and content' do
      get :show, params: { id: @terms_policy.id }
      expect(response.body).to include(@terms_policy.page_title)
      expect(response.body).to include(@terms_policy.content)
    end
  end

end
