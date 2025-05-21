require 'rails_helper'

RSpec.describe BxBlockProfile::CompanyDetail, type: :model do
  let(:country) { AccountBlock::Country.create!(name: "USA") }
  let(:city) { AccountBlock::City.create!(name: "New York", country: country) }
  let(:industry) { BxBlockCategories::Industry.create!(name: "Technology") }
  let(:business_user) { AccountBlock::BusinessUser.create!(email: "user@business.com", password: "Password1!", activated: true) }
  ERROR1 = "can't be blank"
  ERROR2 = "must exist"

  subject {
    described_class.new(
      company_name: "Tech Corp",
      website_link: "https://techcorp.com",
      address: "123 Tech Street",
      country: country,
      city: city,
      industry: industry,
      business_user: business_user,
      country_flag: "india.png"
    )
  }

  describe "validations" do
    it "should raise content type validation" do
      subject.photo = fixture_file_upload(Rails.root.join('spec/fixtures/files/11mb-example.jpg'), 'image/jpeg')
      expect(subject.valid?).to eql(false)
    end

    it "should raise size validation" do
      subject.photo = fixture_file_upload(Rails.root.join('spec/fixtures/files/invalid_user.csv'), 'image/csv')
      expect(subject.valid?).to eql(false)
    end

    it "is not valid without a company_name" do
      subject.company_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:company_name]).to include(ERROR1)
    end

    it "is not valid without a website_link" do
      subject.website_link = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:website_link]).to include(ERROR1)
    end

    it "is not valid without a contact_number" do
      subject.contact_number = "123456789"
      expect(subject).to_not be_valid
      expect(subject.errors[:contact_number]).to eq(["Please enter a valid phone number."])
    end

    it "is not valid without an address" do
      subject.address = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:address]).to include(ERROR1)
    end

    it "is not valid without a country" do
      subject.country = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:country]).to include(ERROR2)
    end

    it "is not valid without a city" do
      subject.city = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:city]).to include(ERROR2)
    end

    it "is not valid without an industry" do
      subject.industry = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:industry]).to include(ERROR2)
    end

    it "is not valid without a business_user" do
      subject.business_user = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:business_user]).to include(ERROR2)
    end
  end
end
