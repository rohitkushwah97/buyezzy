# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockCategories::Category, type: :model do
  subject {
    described_class.new(name: "category-1", identifier: "k12")
  }

  describe "associations" do
    it { should have_and_belong_to_many(:sub_categories) }
    it { should have_many(:ctas).class_name("BxBlockCategories::Cta") }
    it { should have_many(:user_categories).class_name("BxBlockCategories::UserCategory") }
    it { should have_many(:accounts).class_name("AccountBlock::Account") }
  end

  describe "validations" do
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    describe "pass valid identifier" do
      it {
        should define_enum_for(:identifier)
          .with_values([:k12, :higher_education, :govt_job, :competitive_exams, :upskilling])
      }
    end
  end
end
