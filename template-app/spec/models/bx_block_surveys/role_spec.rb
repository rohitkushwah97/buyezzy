require 'rails_helper'

RSpec.describe BxBlockCategories::Role, type: :model do
  let(:industry) { create(:industry) }

  describe 'associations' do
    it { should belong_to(:industry) }
    it { should have_one(:survey).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:role, industry: industry) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:industry_id) }
  end

  describe '#create_survey' do
    it 'creates a survey after the role is created' do
      expect { create(:role, industry: industry) }.to change { BxBlockSurveys::Survey.count }.by(1)
    end

    it 'sets the correct survey name' do
      role = create(:role, name: 'Test Role', industry: industry)
      survey = role.survey

      expect(survey.name).to eq("Test Role - #{industry.name} Quiz")
    end
  end
end
