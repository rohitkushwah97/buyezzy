# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockCategories::SubCategory, type: :model do
  let(:category) { BxBlockCategories::Category.create!(name: "category-1") }
  let(:subcategory) { BxBlockCategories::SubCategory.create!(name: "subcategory-1", categories: FactoryBot.create_list(:category, 1)) }

  subject {
    described_class.new(name: "subcategory-1")
  }

  describe "associations" do
    it { should have_and_belong_to_many(:categories) }
    it { should have_many(:sub_categories).class_name("BxBlockCategories::SubCategory") }
    it { should have_many(:user_sub_categories).class_name("BxBlockCategories::UserSubCategory") }
    it { should have_many(:accounts).class_name("AccountBlock::Account") }

    it "it should have belongs to parent" do
      test = BxBlockCategories::SubCategory.reflect_on_association(:parent)
      expect(test.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    describe "name validations" do
      it "is not valid without a name" do
        subject.name = nil
        expect(subject).to_not be_valid
      end

      it "pass same name" do
        subject.name = "subcategory-1"
        expect(subject).to_not be_valid
      end
    end
  end
end
