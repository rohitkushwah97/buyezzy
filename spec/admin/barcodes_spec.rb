require 'rails_helper'

RSpec.describe Admin::ProductBarcodesController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }
  let(:barcode) { create(:barcode) }

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
    it 'updates the status of barcode' do
      patch :update, params: { id: barcode.id, barcode: { status: false } }
      barcode.reload
      expect(barcode.status).to eq(false)
    end
  end
end
