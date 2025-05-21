# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::CatalogueVariant, type: :model do
  let(:catalogue) { create :catalogue }
  let(:catalogue_variant_color) { create :catalogue_variant_color }
  let(:catalogue_variant_size) { create :catalogue_variant_size }

  let(:catalogue_variants) {create :catalogue_variant,
      catalogue_id: catalogue.id,
      catalogue_variant_color_id: catalogue_variant_color.id,
      catalogue_variant_size_id: catalogue_variant_size.id,
      price: 10.5,
      stock_qty: 3,
      on_sale: true,
      sale_price: 9,
      discount_price: 1,
      length: 3.3,
      breadth: 2.5,
      height: 100
  }
  it "CatalogueVariant belongs to catalogue"do
    expect(catalogue_variants.catalogue.id).to eq (catalogue.id)
  end
  it "CatalogueVariant belongs to catalogue_variant_color"do
    expect(catalogue_variants.catalogue_variant_color.id).to eq (catalogue_variant_color.id)
  end
  it "CatalogueVariant belongs to catalogue_variant_size"do
    expect(catalogue_variants.catalogue_variant_size.id).to eq (catalogue_variant_size.id)
  end
end

