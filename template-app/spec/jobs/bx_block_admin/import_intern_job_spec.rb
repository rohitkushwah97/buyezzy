require 'rails_helper'

RSpec.describe BxBlockAdmin::ImportInternJob, type: :job do
  INTERNUSER = 'AccountBlock::InternUser'
  INVALIDPASS = 'Invalid password'
  let(:valid_user_data) { { 'email' => 'valid@example.com', 'password' => 'password', 'date_of_birth' => '1990-01-01' } }
  let(:invalid_user_data) { { 'email' => 'invalid@example.com', 'password' => '', 'date_of_birth' => 'invalid_date' } }
  
  let(:model_class) { INTERNUSER }

  describe '#process_batch' do
    let(:valid_user) { instance_double(INTERNUSER, save: true, errors: double(full_messages: [])) }
    let(:invalid_user) { instance_double(INTERNUSER, save: false, errors: double(full_messages: [INVALIDPASS])) }

    it 'processes users successfully when all users are valid' do
      batch = [{ user: valid_user, original_row: valid_user_data }]
      errors = []
      allow(valid_user).to receive(:save).and_return(true)
      described_class.new.send(:process_batch, batch, errors)
      expect(errors).to be_empty
    end

    it 'processes users and logs errors when some users are invalid' do
      batch = [
        { user: valid_user, original_row: valid_user_data },
        { user: invalid_user, original_row: invalid_user_data }
      ]
      errors = []
      allow(valid_user).to receive(:save).and_return(true)
      allow(invalid_user).to receive(:save).and_return(false)
      allow(invalid_user.errors).to receive(:full_messages).and_return([INVALIDPASS])
      described_class.new.send(:process_batch, batch, errors)
      expect(errors.first['error']).to eq(INVALIDPASS)
    end
  end

  describe '#perform_now' do
    let(:valid_file) { fixture_file_upload('spec/fixtures/files/intern_user.csv', 'text/csv') }
    let(:invalid_file) { fixture_file_upload('spec/fixtures/files/invalid_intern_user.csv', 'text/csv') }

    it 'processes a valid CSV file' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        described_class.perform_now(valid_file.read, model_class)
      }.to change { BxBlockNotifications::AdminNotification.count }.by(1)
    end

    it 'processes an invalid CSV file' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        described_class.perform_now(invalid_file.read, model_class)
      }.to change { BxBlockNotifications::AdminNotification.count }.by(1)
    end
  end
end
