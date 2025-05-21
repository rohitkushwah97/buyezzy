# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::Catalogue, type: :model do
  let(:category) { create :category }
  let(:sub_category) { create :sub_category }
  let(:brand) { create :brand }
    
  let(:catalogue) { create :catalogue,
    category_id: category.id,
    sub_category_id: sub_category.id,
    brand_id: brand.id,
    name: "Catalogue-1",
    sku: "sku-1",
    description: "First catalogue",
    manufacture_date: DateTime.now,
    length: 10.6,
    breadth: 1.5,
    height: 2,
    stock_qty: 10,
    availability: "in_stock",
    weight: 2.2,
    price: 0.1,
    recommended: true,
    on_sale: false,
    sale_price: 0.05,
    discount: 0.2
  }

  let(:tag1) {create :tag, name: "tag-1"}
  let(:tag2) {create :tag, name: "tag-2"}

  let(:catalogue_variant_color) { create :catalogue_variant_color, name: "Catalogues variants color-1"}
  let(:catalogue_variant_size) {create :catalogue_variant_size ,name: "Catalogues variants size-1"}
  let!(:catalogue_variants) {create :catalogue_variant,
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

  let!(:catalogue_variants1) {create :catalogue_variant,
    catalogue_id: catalogue.id,
    catalogue_variant_color_id: catalogue_variant_color.id,
    catalogue_variant_size_id: catalogue_variant_size.id,
    price: 10.6,
    stock_qty: 4,
    on_sale: true,
    sale_price: 10,
    discount_price: 1,
    length: 3.3,
    breadth: 2.5,
    height: 100
  }
  let!(:review1){create :review,catalogue_id: catalogue.id,rating: 10,comment: "A comment"}
  let!(:review2){create :review,catalogue_id: catalogue.id,rating: 11,comment: "B comment"}

  it "catalogue belongs to category" do
    expect(catalogue.category_id).to eq (category.id)
  end

  it "catalogue belongs to sub_category" do
    expect(catalogue.sub_category_id).to eq (sub_category.id)
  end

  it "catalogue belongs to brand" do
    expect(catalogue.brand_id).to eq (brand.id)
  end

  it "catalogue has many reviews" do
    expect(catalogue.reviews.count). to eq(2)
  end

  it "catalogue has many catalogue_variants" do
    expect(catalogue.catalogue_variants.count). to eq(2)
  end

  it "catalogue has and belongs to many tags" do 
    catalogue.tags << tag1
    catalogue.tags << tag2
    expect(catalogue.tags.count). to eq(2)
  end

  it "test method average_rating for catalogue" do
    expect(catalogue.average_rating). to eq(10.5)
  end
end
