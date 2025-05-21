require 'rails_helper'

RSpec.describe BxBlockHelpCentre::IssueType, type: :model do
  describe 'associations' do
    it { should have_many(:contact_us_inquiries).class_name('BxBlockHelpCentre::ContactUs') }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      issue_type = BxBlockHelpCentre::IssueType.new(name: 'Technical Issue')
      expect(issue_type).to be_valid
    end

    it 'is not valid without a name' do
      issue_type = BxBlockHelpCentre::IssueType.new(name: nil)
      expect(issue_type).not_to be_valid
      expect(issue_type.errors[:name]).to include("can't be blank")
    end
  end
end
