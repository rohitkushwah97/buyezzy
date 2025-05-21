require 'rails_helper'

RSpec.describe BxBlockProfile::Report, type: :model do
  let(:account) { AccountBlock::Account.create!(email: "user@business.com", password: "Password1!", activated: true) }

  VALID_TITLES = {
    inappropriate: 'Inappropriate content',
    misleading: 'Misleading or false information',
    discrimination: 'Discrimination or hate speech',
    other: 'Other'
  }.freeze

  describe 'validations' do
    it { should validate_presence_of(:title) }

    it 'validates title inclusion in VALID_TITLES' do
      VALID_TITLES.values.each do |valid_title|
        report = BxBlockProfile::Report.new(title: valid_title)
        report.valid?
        expect(report.errors[:title]).to be_empty
      end

      report = BxBlockProfile::Report.new(title: 'Invalid title')
      report.valid?
      expect(report.errors[:title]).to include("Invalid title is not a valid report title")
    end

    it 'validates description presence when title is "Other"' do
      report = BxBlockProfile::Report.new(title: VALID_TITLES[:other], description: '', created_by: account, created_for: account)
      report.valid?
      expect(report.errors[:base]).to include("Please provide description for 'Other' title.")
    end

    it 'does not require description for other titles' do
      report = BxBlockProfile::Report.new(title: VALID_TITLES[:inappropriate], description: '', created_by: account, created_for: account)
      report.valid?
      expect(report.errors[:base]).to be_empty
    end
  end

  describe 'callbacks' do
    context 'before_save' do
      it 'sets default description for "Inappropriate content"' do
        report = BxBlockProfile::Report.new(title: VALID_TITLES[:inappropriate], created_by: account, created_for: account)
        report.save
        expect(report.description).to eq("If you believe the information shared on this account is inappropriate, please report the account, and we will evaluate the case. Your report will help us maintain a safe and respectful environment for everyone.")
      end

      it 'sets default description for "Misleading or false information"' do
        report = BxBlockProfile::Report.new(title: VALID_TITLES[:misleading], created_by: account, created_for: account)
        report.save
        expect(report.description).to eq("If you believe the information shared on this account is false or inaccurate, please report the account, and we will evaluate the case. Your report will help us maintain a safe and respectful environment for everyone.")
      end

      it 'sets default description for "Discrimination or hate speech"' do
        report = BxBlockProfile::Report.new(title: VALID_TITLES[:discrimination], created_by: account, created_for: account)
        report.save
        expect(report.description).to eq("If you believe the information shared on this account is discriminatory or contains hate speech, please report the account, and we will evaluate the case. Your report will help us maintain a safe and respectful environment for everyone.")
      end

      it 'does not change description for "Other"' do
        report = BxBlockProfile::Report.new(title: VALID_TITLES[:other], description: 'Custom description', created_by: account, created_for: account)
        report.save
        expect(report.description).to eq('Custom description')
      end
    end
  end
end
