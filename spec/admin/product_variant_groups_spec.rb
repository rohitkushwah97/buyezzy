require 'rails_helper'

RSpec.describe Admin::ProductVariantGroupsController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }
  let(:catalogue) { create(:catalogue) }
  let(:product_variant_group) { create(:product_variant_group, catalogue: catalogue) }

  before do
    sign_in admin_user
  end

  describe 'GET #new' do
    it 'returns a success new response' do
      get :new
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'returns a success edit response' do
      get :edit, params: { id: product_variant_group.id }
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #show' do
    it 'returns a success show response' do
      get :show, params: { id: product_variant_group.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #index' do
    it 'returns a success index response' do
      @product_variant_groups = create_list(:product_variant_group,2, catalogue: catalogue)
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include(@product_variant_groups.first.product_sku)
    end
  end

  describe 'PATCH #update' do
    it 'updates the product_variant_group attributes' do
      new_sku = 'New SKU'
      new_description = 'New Description'
      new_price = 99.99
      new_title = 'New Title'

      patch :update, params: {
        id: product_variant_group.id,
        product_variant_group: {
          product_sku: new_sku,
          product_description: new_description,
          price: new_price,
          product_title: new_title
        }
      }

      product_variant_group.reload

      expect(product_variant_group.product_sku).to eq(new_sku)
      expect(product_variant_group.product_description).to eq(new_description)
      expect(product_variant_group.price.to_s).to eq(new_price.to_s)
      expect(product_variant_group.product_title).to eq(new_title)
    end

    it 'redirects to the catalogue page after update' do
      patch :update, params: { id: product_variant_group.id, product_variant_group: {} }
      expect(response).to redirect_to(admin_product_path(product_variant_group.catalogue))
    end
  end
end
