# frozen_string_literal: true

require "rails_helper"

RSpec.describe BxBlockCategories::Cta, type: :model do
  subject {
    described_class.new(headline: "headline-1", button_text: "button_text-1", redirect_url: "redirect_url-1",
      button_alignment: "centre", text_alignment: "left")
  }

  describe "associations" do
    it "it should have belongs to category" do
      test = BxBlockCategories::Cta.reflect_on_association(:category)
      expect(test.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it "is not valid without a headline" do
      subject.headline = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a button_text" do
      subject.button_text = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a redirect_url" do
      subject.redirect_url = nil
      expect(subject).to_not be_valid
    end

    describe "pass valid text_alignment" do
      it {
        should define_enum_for(:text_alignment)
          .with_values([:centre, :left, :right])
      }
    end

    describe "pass valid button_alignment" do
      it {
        should define_enum_for(:button_alignment)
          .with_values([:centre, :left, :right])
      }
    end
  end
end
