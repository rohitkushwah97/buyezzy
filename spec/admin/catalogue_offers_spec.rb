require 'rails_helper'

RSpec.describe Admin::ProductOffersController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }
  let(:catalogue_offer) { create(:catalogue_offer) }

  before do
    sign_in admin_user
  end

   describe 'GET #new' do
    it 'returns a success new response' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH #update' do
    it 'updates the status of catalogue offer' do
      patch :update, params: { id: catalogue_offer.id, catalogue_offer: { status: false } }
      catalogue_offer.reload
      expect(catalogue_offer.status).to eq(false)
    end
  end
end
