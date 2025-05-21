require 'rails_helper'

RSpec.describe Admin::TopBrandsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @top_brand = create(:top_brand)
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create with invalid params' do
    let(:invalid_params) { { top_brand: { brand_id: nil, sequence_no: 1 } } }

    it 'does not create a new top brand' do
      expect { post :create, params: invalid_params }.not_to change(BxBlockDashboard::TopBrand, :count)
    end

    it '#create renders the new template' do
      post :create, params: invalid_params
      expect(flash[:error]).to include("Brand must exist")
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH update with invalid params' do

    context 'with invalid params' do
      let(:invalid_params) { { id: @top_brand.id, top_brand: { brand_id: nil, sequence_no: -1 } } }

      it 'provides error messages in the flash' do
        patch :update, params: invalid_params
        expect(flash[:error]).to include("Sequence no must be greater than or equal to 1")
        expect(response).to render_template(:edit)
      end

      it 'renders the edit template' do
        patch :update, params: invalid_params
       
      end
    end
  end

end
