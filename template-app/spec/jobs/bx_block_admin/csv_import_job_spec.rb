require 'rails_helper'

RSpec.describe BxBlockAdmin::CsvImportJob, type: :job do
  TEXT = 'text/csv'
  let(:valid_file) { fixture_file_upload('spec/fixtures/files/intern_user.csv', TEXT) }
  let(:invalid_file) { fixture_file_upload('spec/fixtures/files/invalid_user.csv', TEXT) }

  describe "#perform_now" do
    model = 'AccountBlock::BusinessUser'
    it "create survey question valid csv" do
      ActiveJob::Base.queue_adapter = :test
      res = described_class.perform_now(valid_file.read,model)
      expect(res.present?).to eq(true)
    end
    
    it "create survey question with invalid csv file" do
      ActiveJob::Base.queue_adapter = :test
      res = described_class.perform_now(invalid_file.read,model)
      expect(res.present?).to eq(true)
    end
  end
end