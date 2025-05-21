require 'rails_helper'

RSpec.describe Admin::CatalogueContentsController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }
  let(:catalogue_content) { create(:catalogue_content) }

  before do
    sign_in admin_user
  end

  describe "GET new" do
    it "displays the new catalogue content form" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH #update' do
    it 'updates the status of catalogue content' do
      patch :update, params: { id: catalogue_content.id, catalogue_content: { status: false } }
      catalogue_content.reload
      expect(catalogue_content.status).to eq(false)
    end
  end
end
