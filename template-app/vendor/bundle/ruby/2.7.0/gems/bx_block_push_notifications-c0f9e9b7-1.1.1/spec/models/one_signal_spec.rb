require 'rails_helper'

RSpec.describe BxBlockPushNotifications::Providers::OneSignal, type: :services do
  let(:title) { 'Test title' }
  let(:message) { 'Push notifications contents' }
  let(:app_url) { 'app://app.url' }
  let(:user_ids) { ['0e1d2dbf-ff19-4cbd-87a1-2f3591079991'] }

  let(:application_id) { '123412312451212' }
  let(:auth_token) { '900900900900900900900900' }

  let!(:stub) do
    stub_request(:post, 'https://onesignal.com/api/v1/notifications').
      with(body: expected_body.to_json, headers: {
        'Content-Type' => 'application/json;charset=utf-8',
        'Authorization' => "Basic #{auth_token}"
      }).
      to_return(status: 200, body: "{}", headers: {})
  end

  let(:expected_body) do
    {
      'app_id' => application_id,
      'contents' => {'en' => message},
      'headings' => {'en' => title },
      'app_url' =>  app_url,
      'include_player_ids' => user_ids
    }
  end

  before do
    allow(Rails.configuration.x.push_notifications)
      .to receive(:application_id).and_return(application_id)
    allow(Rails.configuration.x.push_notifications).to receive(:auth_token).and_return(auth_token)
  end

  describe '.send_push_notification' do
    it 'calls one signal api correctly' do
      described_class.send_push_notification(title: title,
                                             message: message,
                                             app_url: app_url,
                                             user_ids: user_ids)
      expect(stub).to have_been_requested
    end
  end
end
