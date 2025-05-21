require 'rails_helper'

RSpec.describe BxBlockAdmin::ImportSurveyQuestionJob, type: :job do
  let!(:role)  { create(:role, name: "test role") }
  let(:valid_file) { fixture_file_upload('spec/fixtures/files/valid_csv_questions.csv', TEXT) }
  let(:invalid_file) { fixture_file_upload('spec/fixtures/files/invalid_csv_questions.csv', TEXT) }
  let!(:intern_characteristic) { create(:intern_characteristic, name: "Technical Skills") }

  describe "#perform_now" do
    it "create survey question" do
      ActiveJob::Base.queue_adapter = :test
      res = described_class.perform_now(valid_file.read)
      expect(res.present?).to eq(true)
    end
    
    it "create survey question with invalid csv" do
      ActiveJob::Base.queue_adapter = :test
      res = described_class.perform_now(invalid_file.read)
      expect(res.present?).to eq(true)
    end
  end
end