require 'rails_helper'

RSpec.describe AccountBlock::Accounts::SmsConfirmationsController, type: :request do
  
  describe 'POST create' do
    let(:confirmation_path) { '/account_block/accounts/sms_otp_confirmations' }
    let(:sms_otp) { create(:sms_otp) }
    let(:token) { BuilderJsonWebToken.encode(sms_otp.id) }
    let(:valid_params) { { pin: sms_otp.pin } }
    let(:unifonic) {"https://el.cloud.unifonic.com/rest/SMS/messages"}
    let(:headers) {{
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>'Ruby'
          }}

          before do
            stub_request(:post, unifonic)
            .with(
              body: {
                "AppSid"=>ENV['UNIFONIC_APPSID'],
                "Body"=>"Your Pin Number is #{sms_otp.pin}",
                "Recipient"=> sms_otp.full_phone_number,
                "SenderID"=>ENV['UNIFONIC_SENDERID'],
                "async"=>"true"
              },
              headers: headers
              )
            .to_return(status: 200, body: "", headers: {})
          end

    context 'when the pin is valid' do
      it 'confirms the phone number and returns a success response' do

        post confirmation_path, params: valid_params, headers: {token: token}

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Phone Number Confirmed Successfully')
        expect(response.body).to include('token')

        sms_otp.reload
        expect(sms_otp.activated).to be true
      end
    end

    context 'when the pin is invalid' do
      let(:invalid_params) { { pin: '123456' } }

      it 'returns an error response' do
        post confirmation_path, params: invalid_params, headers: {token: token}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Invalid Pin for Phone Number')

        sms_otp.reload
        expect(sms_otp.activated).to be false
      end
    end

    context 'when the SMS OTP has expired' do
      let(:expired_sms_otp) { create(:sms_otp, activated: true) }
      let(:exptoken) { BuilderJsonWebToken.encode(expired_sms_otp.id) }
      let(:expired_params) { { pin: expired_sms_otp.pin } }

      it 'returns an error response' do
        stub_request(:post, unifonic)
        .with(
          body: {
            "AppSid"=>ENV['UNIFONIC_APPSID'],
            "Body"=>"Your Pin Number is #{expired_sms_otp.pin}",
            "Recipient"=> expired_sms_otp.full_phone_number,
            "SenderID"=>ENV['UNIFONIC_SENDERID'],
            "async"=>"true"
          },
          headers: headers
          )
        .to_return(status: 200, body: "", headers: {})
        expired_sms_otp.update(valid_until: 1.day.ago)
        post confirmation_path, params: expired_params, headers: {token: exptoken}

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('This Pin has expired')

        expect(AccountBlock::SmsOtp.exists?(expired_sms_otp.id)).to be false
      end
    end

    context 'when the phone number is already activated' do
      let(:activated_sms_otp) { create(:sms_otp, activated: true) }
      let(:token) { BuilderJsonWebToken.encode(activated_sms_otp.id) }
      let(:activated_params) { { pin: activated_sms_otp.pin } }

      it 'returns a success response with a message' do
        stub_request(:post, unifonic)
        .with(
          body: {
            "AppSid"=>ENV['UNIFONIC_APPSID'],
            "Body"=>"Your Pin Number is #{activated_sms_otp.pin}",
            "Recipient"=> activated_sms_otp.full_phone_number,
            "SenderID"=>ENV['UNIFONIC_SENDERID'],
            "async"=>"true"
          },
          headers: headers
          )
        .to_return(status: 200, body: "", headers: {})
        post confirmation_path, params: activated_params, headers: {token: token}

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Phone Number Already Activated')

        expect(activated_sms_otp.activated).to be true
      end
    end
  end
end
