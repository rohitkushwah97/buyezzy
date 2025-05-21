require 'rails_helper'

RSpec.describe BxBlockSurveys::Question, type: :model do
  let(:survey) { create(:survey) }
  let(:version) { create(:version) }

  describe 'associations' do
    it { should belong_to(:survey).class_name('BxBlockSurveys::Survey') }
    it { should belong_to(:version).class_name('BxBlockSurveys::Version').optional }
    it { should belong_to(:intern_characteristic).class_name('BxBlockSurveys::InternCharacteristic') }
    it { should have_many(:options).class_name('BxBlockSurveys::Option').dependent(:destroy) }
  end

  describe "validations" do

    context 'must create 5 options' do
      let!(:question) {create(:question, survey_id: survey.id, version_id: version.id)}
      it 'is valid with exactly 5 options' do
        question.options.destroy_all

        5.times do |i|
          question.options.build(name: "Option #{i + 1}")
        end
        
        expect(question).to be_valid
      end
    end

      it 'is invalid if less than 5 options are present' do
        question = build(:question, survey: survey, version: version)
        
        # Only build 4 options to simulate error
        4.times do |i|
          question.options.build(name: "Option #{i + 1}")
        end
        
        expect(question).not_to be_valid
        expect(question.errors[:options]).to include('must have exactly 5 options')
      end

      it 'is invalid if more than 5 options are present' do
        question = build(:question, survey: survey, version: version)
        
        # Build 6 options to simulate error
        6.times do |i|
          question.options.build(name: "Option #{i + 1}")
        end
        
        expect(question).not_to be_valid
        expect(question.errors[:options]).to include('must have exactly 5 options')
      end
  end
end
