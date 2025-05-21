require 'rails_helper'

RSpec.describe BxBlockSurveys::Survey, type: :model do
  describe 'associations' do
    it { should belong_to(:role).class_name('BxBlockCategories::Role') }
    it { should have_many(:questions).class_name('BxBlockSurveys::Question').dependent(:destroy) }
    it { should have_many(:versions).class_name('BxBlockSurveys::Version').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name).on(:create) }

    context 'custom validation' do
      let(:role) { create(:role) }
      let(:survey) { described_class.new(name: 'Test Survey', role: role) }

      # it 'is invalid if no questions are added' do
      #   survey.skip_minimum_questions_validation = false
      #   survey.valid?

      #   expect(survey.errors[:questions]).to include('Atleast 1 Question must be added.')
      # end

      it 'is valid when at least one question is added' do
        survey.questions.build(default_weight: 50, business_question: 'Business question', intern_question: 'Intern question')        
        survey.valid?

        expect(survey.errors[:questions]).to be_empty
      end

      it 'skips question validation when skip_minimum_questions_validation is true' do
        survey.skip_minimum_questions_validation = true
        survey.valid?
        
        expect(survey.errors[:questions]).to be_empty
      end
    end
  end
end
