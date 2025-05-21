require 'rails_helper'

RSpec.describe Admin::ProductContentsController, type: :controller do
  render_views

  let(:admin_user) { create(:admin_user) }
  let(:catalogue) { create(:catalogue, product_image: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg"))) }
  let(:product_content) { create(:product_content, catalogue: catalogue) }
  let!(:size_and_capacity) { create(:size_and_capacity, product_content: product_content) }
  let!(:shipping_detail) { create(:shipping_detail, product_content: product_content) }
  let!(:image_urls) { create(:image_url, product_content: product_content) }
  let!(:feature_bullets) { create(:feature_bullet, product_content: product_content) }
  let!(:special_features) { create(:special_feature, product_content: product_content) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a success index response' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'index displays product content details in response body' do
      get :index
      
      expect(response.body).to include(product_content.gtin)
      expect(response.body).to include(product_content.brand_name)
    end
  end

  describe 'GET #show' do
    it 'returns a success show response' do
      get :show, params: { id: product_content.id }
      expect(response).to be_successful
    end

    it 'displays product content details in response body' do
      get :show, params: { id: product_content.id }
      
      expect(response.body).to include(product_content.gtin)
      expect(response.body).to include(product_content.brand_name)
      expect(response.body).to include(size_and_capacity.size.to_s)
      expect(response.body).to include(shipping_detail.shipping_length.to_s)
    end
  end

  describe 'GET #new' do
    it 'returns a success new response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with invalid params' do
      let(:invalid_attributes) { {retail_price: 123} }

      it 'returns a success response (renders the new template)' do
        post :create, params: { product_content: invalid_attributes }
        expect(response).to render_template(:new)
      end

      it 'displays flash errors' do
        post :create, params: { product_content: invalid_attributes }
        expect(flash[:main_model_errors]).not_to be_nil
        expect(flash[:image_urls_errors]).to include("Image URLs: At least one Image Url must be present")
        expect(flash[:feature_bullets_errors]).to include("Feature Bullets: At least one Feature Bullet must be present")
      end
    end
  end

  describe 'PUT #update' do

    context 'with invalid params' do
      let(:invalid_attributes) { {retail_price: nil, image_urls_attributes: {id: nil, url: nil}, feature_bullets_attributes: {id: nil, value: nil} } }
      it 'returns a success response (renders the edit template)' do
        put :update, params: { id: product_content.id, product_content: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(flash[:main_model_errors]).to eq("Image urls url can't be blank, Image urls url should start with 'https://' or 'www.', Feature bullets value can't be blank, Retail price can't be blank")
      end
    end
  end

  # describe 'DELETE #destroy' do
  #   # it 'destroys the requested product content' do
  #   #   expect {
  #   #     delete :destroy, params: { id: product_content.id }
  #   #   }.to change(BxBlockCatalogue::ProductContent, :count).by(-1)
  #   # end

  #   # it 'redirects to the product content list' do
  #   #   delete :destroy, params: { id: product_content.id }
  #   #   expect(response).to redirect_to(admin_product_path(product_content.catalogue))
  #   # end
  # end
end
