require 'rails_helper'

RSpec.describe 'BxBlockLogin::LoginsController', type: :request do
	before(:all) do
		LOGIN = "/bx_block_login/logins"
		@current_user = create(:account, user_type: "buyer", activated: true)
		image = fixture_file_upload('files/Sample.jpg', 'image/jpeg')
		@current_user.profile_picture.attach(io: File.open(image), filename: 'Sample.jpg', content_type: 'image/jpeg')
		@seller_pass = "Password@1234"
		@current_user2 = create(:account, user_type: "seller", password: @seller_pass)
		@token = BuilderJsonWebToken.encode(@current_user.id) 
		@doc_name = "document.pdf"
	end
	
	describe 'POST Login ' do
		context "Login Successfully with Email" do
			let(:params) do
				{
					"data": {
						"type": "email_account",
						"user_type": "seller",
						"attributes": {
							"email": @current_user2.email,
							"password": "Password@1234"
						}
					}
				}
			end
			it 'should return when account login with email Successfully' do
				@current_user2.update(activated: true)

				post LOGIN, params: params
				expect(response).to have_http_status(:ok)
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['meta']['document_status']).to eq("No documents uploaded")
			end

			it 'should return when account document in verification' do
				@current_user3 = create(:account, user_type: "seller", password: @seller_pass, activated: true)
				@seller_document1 = FactoryBot.create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", @doc_name))], account: @current_user3)
				params[:data][:attributes][:email] = @current_user3.email

				post LOGIN, params: params
				expect(response).to have_http_status(:ok)
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['meta']['document_status']).to eq("Your Document verification is in progress")
			end

			it 'should return when account document approved' do
				@current_user4 = create(:account, user_type: "seller", password: @seller_pass, activated: true)
				@seller_document1 = FactoryBot.create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", @doc_name))], account: @current_user4)
				@seller_document1.update(approved: true)
				params[:data][:attributes][:email] = @current_user4.email

				post LOGIN, params: params
				expect(response).to have_http_status(:ok)
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['meta']['document_status']).to eq("Your document has been verified")
			end

			it 'should return when account document rejected' do
				@current_user5 = create(:account, user_type: "seller", password: @seller_pass, activated: true)
				@seller_document1 = FactoryBot.create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", @doc_name))], account: @current_user5)
				@seller_document1.update(rejected: true)
				params[:data][:attributes][:email] = @current_user5.email

				post LOGIN, params: params
				expect(response).to have_http_status(:ok)
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['meta']['document_status']).to eq("Rejected: #{@seller_document1.document_name}")
			end

			it 'should return when account not found' do
				post LOGIN, params: params
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['errors'][0]['failed_login']).to eq('The email is not register or not activated')
			end

		end

		context "Login with Email for profile picture" do
			let(:params) do
				{
					"data": {
						"type": "email_account",
						"user_type": "buyer",
						"attributes": {
							"email": "#{@current_user.email}",
							"password": "Password@123"
						}
					}
				}
			end
			
			it 'should return when account login with profile image Successfully' do
				post LOGIN, params: params
				expect(@current_user.reload.profile_picture).to be_attached
			end

			it 'should return when account login with error' do
				params[:data][:attributes][:password] = @seller_pass
				post LOGIN, params: params
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['errors'][0]['failed_login']).to eq('Email or Password incorrect please try again')
			end

			it 'should return when account login with error invalid type' do
				params[:data][:type] = "invalid_type"
				post LOGIN, params: params
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['errors'][0]['account']).to eq('Invalid Account Type')
			end

		end

		context "sent otp" do
			let(:params) do
				{
					"data": {
						"attributes": {
							"full_phone_number": @current_user.full_phone_number
						}
					}
				}
			end
			it 'should send otp' do
				allow_any_instance_of(AccountBlock::SmsOtp).to receive(:generate_pin_and_valid_date) do |sms_otp|
					sms_otp.pin = '54321'
					sms_otp.valid_until = Time.current + 5.minutes
				end
				stub_request(:post, "https://el.cloud.unifonic.com/rest/SMS/messages")
				.with(
					body: {
						"AppSid" => ENV['UNIFONIC_APPSID'],
						"Body" => "Your Pin Number is 54321",
						"Recipient" => "+#{@current_user.full_phone_number}",
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
				post '/send_login_otp',params: params, headers: {token: @token}
				expect(response).to have_http_status(:created)
				expect(ActionMailer::Base.deliveries.count).to eq(1)
			end
		end
	end
end
