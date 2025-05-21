require 'rails_helper'

RSpec.describe Admin::TaxAndLegalPoliciesController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @privacy = create(:privacy_and_legal_policy)
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@privacy.title)
      expect(response.body).to include(@privacy.content)
      expect(response.body).to include(@privacy.status.to_s)
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, params: { id: @privacy.id }
      expect(response).to render_template(:show)
    end

    it 'displays the page title and content' do
      get :show, params: { id: @privacy.id }
      expect(response.body).to include(@privacy.title)
      expect(response.body).to include(@privacy.content)
    end
  end

end
