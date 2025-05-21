require 'rails_helper'

RSpec.describe BxBlockCatalogue::ProductVariantGroup, type: :model do
  let(:catalogue) { create(:catalogue) }
  let(:product_content) { create(:product_content, catalogue: catalogue) }
  let!(:size_and_capacity) { create(:size_and_capacity, product_content: product_content) }
  let!(:shipping_detail) { create(:shipping_detail, product_content: product_content) }
  let!(:image_urls) { create(:image_url, product_content: product_content) }
  let!(:feature_bullets) { create(:feature_bullet, product_content: product_content) }
  let(:product_variant_group) { build(:product_variant_group, catalogue: catalogue) }

  describe 'validations' do
    it 'validates presence of product_sku' do
      product_variant_group.product_sku = nil
      expect(product_variant_group).not_to be_valid
      expect(product_variant_group.errors[:product_sku]).to include("can't be blank")
    end

    it 'validates uniqueness of product_sku' do
      create(:product_variant_group, product_sku: 'unique_sku')
      product_variant_group.product_sku = 'unique_sku'
      expect(product_variant_group).not_to be_valid
      expect(product_variant_group.errors[:product_sku]).to include('must be unique across catalogues and product variant groups')
    end
  end

  describe '#create_and_associate_variant_product' do
    it 'creates a variant product associated with the product_variant_group' do
      product_variant_group.save!
      product_variant_group.create_and_associate_variant_product
      product_variant_group.reload
      expect(product_variant_group.variant_product).not_to be_nil
      expect(product_variant_group.variant_product.parent_product).to eq(catalogue)
      expect(product_variant_group.variant_product.is_variant).to be true
    end
  end
end