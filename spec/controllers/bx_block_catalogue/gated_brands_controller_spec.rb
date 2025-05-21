require 'rails_helper'

RSpec.describe BxBlockCatalogue::GatedBrandsController, type: :controller do

  before do
    @account = FactoryBot.create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @brand = create("brand")
    @gated_brand = create(:gated_brand, brand: @brand)
  end

  let(:valid_attributes) {
    {token: @token, brand_id: @brand.id, approved: true, reseller_permit_document: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "document.pdf")) }
  }

  let(:invalid_attributes) {
    {token: @token, brand_id: 999, approved: true, reseller_permit_document: nil }
  }

  describe 'GET #index' do
    it 'returns a success response index' do
      get :index, params: {brand_id: @brand.id}
      expect(response).to be_successful
      expect(response.body).to include(@gated_brand.brand_id.to_s)
    end
  end

  describe 'GET #show' do
    it 'returns a success response show' do
      get :show, params: { id: @gated_brand.id, brand_id: @brand.id }
      expect(response).to be_successful
      expect(response.body).to include(@gated_brand.approved.to_s)
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("reseller_permit_document")
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new GatedBrand' do
        expect {
          post :create, params: valid_attributes
        }.to change(BxBlockCatalogue::GatedBrand, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors'][0]).to eq("Brand must exist")
      end
    end
  end
end
