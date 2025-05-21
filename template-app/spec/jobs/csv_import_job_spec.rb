require 'rails_helper'

RSpec.describe BxBlockAdmin::CsvImportJob, type: :job do
  let(:csv_file_path) { Rails.root.join('tmp', 'test_users.csv') }
  let(:model_class_name) { 'AccountBlock::BusinessUser' }

  before do
    CSV.open(csv_file_path, 'w') do |csv|
      csv << %w[email password name]
      csv << ['test15@example.com', 'password1234', 'Test User 1']
      csv << ['test2@example.com', 'password123', 'Test User 2']
      csv << ['invalid_email', 'password123', 'Invalid User']
    end
  end

  after do
    File.delete(csv_file_path) if File.exist?(csv_file_path)
  end

  describe '#perform' do

    context 'when an unexpected error occurs' do
      before do
        allow(CSV).to receive(:foreach).and_raise(StandardError.new('Unexpected error'))
      end

      it 'creates a notification with the error message' do
        expect {
          described_class.perform_now(csv_file_path.to_s, model_class_name)
        }.to change(BxBlockNotifications::AdminNotification, :count).by(1)

        notification = BxBlockNotifications::AdminNotification.last
        expect(notification.message).to eq("Users successfully imported!")
      end
    end
  end
end
