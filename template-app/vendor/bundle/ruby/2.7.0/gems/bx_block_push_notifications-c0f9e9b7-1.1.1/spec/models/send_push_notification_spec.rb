require 'rails_helper'

RSpec.describe BxBlockPushNotifications::SendPushNotification, type: :services do
  let(:title) { 'Test title' }
  let(:message) { 'Push notifications contents' }
  let(:app_url) { 'app://app.url' }
  let(:user_ids) { ['0e1d2dbf-ff19-4cbd-87a1-2f3591079991'] }

  describe '#call' do
    subject(:service) do
      described_class.new(title: title, message: message, app_url: app_url, user_ids: user_ids)
    end

    context 'when one_signal is configured as the provider' do
      before do
        allow(Rails.configuration.x.push_notifications)
          .to receive(:provider).and_return(:one_signal)
      end

      it 'calls the one_signal provider' do
        expect(BxBlockPushNotifications::Providers::OneSignal)
          .to receive(:send_push_notification).with(title: title,
                                                    message: message,
                                                    app_url: app_url,
                                                    user_ids: user_ids)
        service.call
      end
    end

    context 'when no provider is configured' do
      before do
        allow(Rails.configuration.x.push_notifications).to receive(:provider).and_return(nil)
      end

      it 'raises an error' do
        expect {
          service.call
        }.to raise_error('You must specify a Push Notifications provider. Supported: one_signal.')
      end
    end

    context 'when a not supported provider is configured' do
      before do
        allow(Rails.configuration.x.push_notifications).to receive(:provider).and_return(:fancy)
      end

      it 'raises an error' do
        expect {
          service.call
        }.to raise_error('Unsupported Push Notifications provider: fancy. Supported: one_signal.')
      end
    end
  end
end
