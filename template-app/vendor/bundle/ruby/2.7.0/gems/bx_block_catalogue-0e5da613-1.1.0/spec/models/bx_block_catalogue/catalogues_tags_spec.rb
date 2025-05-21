# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::CataloguesTag, type: :model do
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

  it "catalogue has and belongs to many tags" do 
    catalogue.tags << tag1
    catalogue.tags << tag2
    expect(BxBlockCatalogue::CataloguesTag.count). to eq(2)
  end
end
