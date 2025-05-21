# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::Brand, type: :model do

  context 'Brand Validations' do
    it 'name should be valid brand create' do
      brand = FactoryBot.create(:brand,name: Faker::Name.name,currency: "USD")
      expect(brand).to be_valid
    end
    it "should not let a brand be created without an name" do
      brand = FactoryBot.create(:brand,name: "Brand-5",currency: "USD")
      brand.name = nil
      expect(brand).to_not be_valid
    end
    it 'currency should be valid brand create' do
      brand = FactoryBot.create(:brand,name: "Brand-6",currency: "USD")
      expect(brand).to be_valid
    end
    it "should not let a brand be created without an currency" do
      brand = FactoryBot.create(:brand,name: "Brand-88",currency: "USD")
      brand.update(currency: nil)
      expect(brand).to_not be_valid
    end
  end
end
