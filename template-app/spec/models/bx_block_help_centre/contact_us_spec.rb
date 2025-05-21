require 'rails_helper'

RSpec.describe BxBlockHelpCentre::ContactUs, type: :model do
  describe 'validations' do
    let(:issue_type) { BxBlockHelpCentre::IssueType.create(name: 'Technical Issue') }

    ERROR = "can't be blank"
    NAME = 'John Doe'
    EMAIL = 'john.doe@example.com'
    INQUIRY = 'I need help with my account.'

    it 'is valid with valid attributes' do
      contact_us = BxBlockHelpCentre::ContactUs.new(
        full_name: NAME,
        email: EMAIL,
        issue_type: issue_type,
        inquiry_details: INQUIRY
      )
      expect(contact_us).to be_valid
    end

    it 'is not valid without a full name' do
      contact_us = BxBlockHelpCentre::ContactUs.new(
        full_name: nil,
        email: EMAIL,
        issue_type: issue_type,
        inquiry_details: INQUIRY
      )
      expect(contact_us).not_to be_valid
      expect(contact_us.errors[:full_name]).to include(ERROR)
    end

    it 'is not valid without an email' do
      contact_us = BxBlockHelpCentre::ContactUs.new(
        full_name: NAME,
        email: nil,
        issue_type: issue_type,
        inquiry_details: INQUIRY
      )
      expect(contact_us).not_to be_valid
      expect(contact_us.errors[:email]).to include(ERROR)
    end

    it 'is not valid with an invalid email format' do
      contact_us = BxBlockHelpCentre::ContactUs.new(
        full_name: NAME,
        email: 'invalid_email',
        issue_type: issue_type,
        inquiry_details: INQUIRY
      )
      expect(contact_us).not_to be_valid
      expect(contact_us.errors[:email]).to include("must be a valid email address")
    end

    it 'is not valid without an issue type' do
      contact_us = BxBlockHelpCentre::ContactUs.new(
        full_name: NAME,
        email: EMAIL,
        issue_type: nil,
        inquiry_details: INQUIRY
      )
      expect(contact_us).not_to be_valid
      expect(contact_us.errors[:issue_type]).to include("must exist")
    end

    it 'is not valid without inquiry details' do
      contact_us = BxBlockHelpCentre::ContactUs.new(
        full_name: NAME,
        email: EMAIL,
        issue_type: issue_type,
        inquiry_details: nil
      )
      expect(contact_us).not_to be_valid
      expect(contact_us.errors[:inquiry_details]).to include(ERROR)
    end

    it 'is not valid if inquiry details exceed 500 characters' do
      long_inquiry = 'a' * 501
      contact_us = BxBlockHelpCentre::ContactUs.new(
        full_name: NAME,
        email: EMAIL,
        issue_type: issue_type,
        inquiry_details: long_inquiry
      )
      expect(contact_us).not_to be_valid
      expect(contact_us.errors[:inquiry_details]).to include("is too long (maximum is 500 characters)")
    end
  end
end