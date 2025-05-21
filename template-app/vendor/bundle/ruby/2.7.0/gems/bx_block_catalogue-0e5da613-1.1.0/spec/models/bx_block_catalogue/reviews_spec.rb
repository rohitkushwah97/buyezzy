# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::Review, type: :model do
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
    length: 10.5,
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
  let(:review) {
    create :review,
    catalogue_id: catalogue.id,
    rating: 10,
    comment: "A comment"
  }
  it "review belongs to catalogue" do
   expect(review.catalogue_id).to eq (catalogue.id)
  end
end

