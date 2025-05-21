require 'rails_helper'

RSpec.describe AccountBlock::Accounts::SendOtpsController, type: :request do
  before(:all) do
    @account = create(:account, user_type: "buyer")
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end
  let(:params) {
      {
        "data": {
          "attributes": {
            "full_phone_number": "919876444210"
          }
        }
      }
  }
  describe "POST create" do
    send_otp_path = "/account_block/accounts/send_otps"
    it "generates and returns OTP for a new account" do
      allow_any_instance_of(AccountBlock::SmsOtp).to receive(:generate_pin_and_valid_date) do |sms_otp|
        sms_otp.pin = '54321'
        sms_otp.valid_until = Time.current + 5.minutes
      end
      stub_request(:post, "https://el.cloud.unifonic.com/rest/SMS/messages")
        .with(
          body: {
            "AppSid" => ENV['UNIFONIC_APPSID'],
            "Body" => "Your Pin Number is 54321",
            "Recipient" => "+919876444210",
            "SenderID" => ENV['UNIFONIC_SENDERID'],
            "async" => "true"
          },
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/x-www-form-urlencoded',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: "", headers: {})
      post send_otp_path, params: params, headers: {token: @token}
      expect(response).to have_http_status(:created)
      
    end

    it "generates and returns OTP for a new account in email" do
      params[:data][:attributes][:full_phone_number] = @account.full_phone_number
      allow_any_instance_of(AccountBlock::SmsOtp).to receive(:generate_pin_and_valid_date) do |sms_otp|
        sms_otp.pin = '54321'
        sms_otp.valid_until = Time.current + 5.minutes
      end
      stub_request(:post, "https://el.cloud.unifonic.com/rest/SMS/messages").
         with(
           body: {
            "AppSid"=> ENV['UNIFONIC_APPSID'], 
            "Body"=>"Your Pin Number is 54321", 
            "Recipient"=> "+#{params[:data][:attributes][:full_phone_number]}", 
            "SenderID"=> ENV['UNIFONIC_SENDERID'], 
            "async"=>"true"
          },
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "", headers: {})
      post send_otp_path, params: params, headers: {token: @token}
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      
    end

    it "returns an error for an already activated account" do
      @account.update(activated: true)
      params[:data][:attributes][:full_phone_number] = @account.full_phone_number
      post send_otp_path, params: params, headers: {token: @token}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("\"account\":\"Account already activated\"")
    end

    it "returns an error for failed OTP generation" do
      params[:data][:attributes][:full_phone_number] = "2345"
      post send_otp_path, params: params, headers: {token: @token}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("\"Full phone number Invalid or Unrecognized Phone Number\"")
    end
  end
end
