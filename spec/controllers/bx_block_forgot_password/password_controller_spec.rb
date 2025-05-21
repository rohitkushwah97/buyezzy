require 'rails_helper'

RSpec.describe "BxBlockForgotPassword::PasswordsController", type: :request do
	before(:all) do 
		PASSWORD = "Password@123"
		@current_user = FactoryBot.create(:account, user_type: "seller")
		@buyer_user = FactoryBot.create(:account, user_type: "buyer")
		# @reset_token = []
		@error_msg = "The email is not registered or Email id is not valid"
	end


	describe "forgot and reset password" do 
		context "forgot password" do
			let(:forgot_password_url) { '/forgot_password' }

			it "success" do 
				post forgot_password_url, params:  { data: {"user_type": @current_user.user_type,"email": "#{@current_user.email}" } }
				# @reset_token << JSON.parse(response.body)['message']['reset_token']
				expect(response).to have_http_status(201)
			end

			it "seller forgot password success" do 
				post forgot_password_url, params:  { data: {"user_type": 'seller',"email": "#{@current_user.email}" } }
				expect(response).to have_http_status(201)
			end

			it "buyer forgot password success" do 
				post forgot_password_url, params:  { data: {"user_type": 'buyer',"email": "#{@buyer_user.email}" } }
				expect(response).to have_http_status(201)
			end

			it "email failures" do 
				post forgot_password_url, params:  { data: {"user_type": @current_user.user_type, "email": "testmail.com" } }
				expect(response).to have_http_status(422)
				expect(JSON.parse(response.body)['errors'][0]['profile']).to eq(@error_msg)
			end

			it "user type failures" do 
				post forgot_password_url, params:  { data: {"user_type": "buyer", "email": "#{@current_user.email}" } }
				expect(response).to have_http_status(422)
				expect(JSON.parse(response.body)['errors'][0]['profile']).to eq(@error_msg)
			end

			it "blank email failures" do 
				post forgot_password_url, params:  { data: {"user_type": @current_user.user_type, "email": nil } }
				expect(response).to have_http_status(422)
				expect(JSON.parse(response.body)['errors'][0]['profile']).to eq('Email id should not be blank')
			end

		end

		context "reset password" do
			let(:reset_password_url) { '/reset_password' }
			let(:token) { BuilderJsonWebToken.encode(@current_user.id, 10.minutes.from_now) }
			it "password set successfully" do 
				patch reset_password_url, params: {
					data: {
						token: token,
						new_password: PASSWORD,
						confirm_password: PASSWORD
					}
				}
				expect(response).to have_http_status 200
			end

			it 'returns the serialized account' do
				patch reset_password_url, params: {
					data: {
						token: token,
						new_password: PASSWORD,
						confirm_password: PASSWORD
					}
				}
				expect(JSON.parse(response.body)['data']).to be_present
			end

			it "reset password failures" do 
				patch reset_password_url, params: {
					data: {
						token: token,
						new_password: PASSWORD,
						confirm_password: "Test@1123"
					}
				}
				expect(response).to have_http_status 422
			end

			it 'returns an error message' do
				patch reset_password_url, params: {
					data: {
						token: 'invalid token',
						new_password: PASSWORD,
						confirm_password: PASSWORD
					}
				}
				expect(JSON.parse(response.body)['errors'][0]['token']).to eq('Invalid token')
			end

			it 'returns an error message for blank params' do
				patch reset_password_url, params: {
					data: {
						token: ' ',
						new_password: PASSWORD,
						confirm_password: PASSWORD
					}
				}
				expect(JSON.parse(response.body)['errors'][0]['reset_password']).to eq('Token, New Password, and Confirm Password are required')
			end

			it 'returns an error expired message' do
				expired_user = FactoryBot.create(:account)
				expired_token = BuilderJsonWebToken.encode(expired_user.id,1.minutes.ago)
				expired_user.update(reset_token: expired_token)
				patch reset_password_url, params: {
					data: {
						token: expired_token,
						new_password: PASSWORD,
						confirm_password: PASSWORD
					}
				}
				expect(JSON.parse(response.body)['errors'][0]['token']).to eq("Token has expired or has already been used")
			end

			it 'returns an error status' do
				patch reset_password_url, params: {
					data: {
						token: token,
						new_password: PASSWORD,
						confirm_password: "invalid password"
					}
				}
				expect(response).to have_http_status(:unprocessable_entity)
			end

		end

		context "current password check" do
			let(:current_password_url) { '/current_password' }
			let(:valid_token) { BuilderJsonWebToken.encode(@current_user.id, 10.minutes.from_now) }
			it "success" do 
				post current_password_url, params:  {
					data: {
						token: valid_token,
						current_password: PASSWORD
					}
				}
				expect(response).to have_http_status(200)
			end

			it "fail wrong password" do 
				post current_password_url, params: {
					data: {
						token: valid_token,
						current_password: "ssss"
					}
				}
				expect(response).to have_http_status(422)
				expect(JSON.parse(response.body)['data']).to eq(false)
				expect(JSON.parse(response.body)['message']).to eq("Current Password is not correct")
			end


			# it "fail invalid token" do 
			# 	post current_password_url, params: {
			# 		data: {
			# 			token: "invalid_token",
			# 			current_password: "ssss"
			# 		}
			# 	}
			# 	expect(response).to have_http_status(422)
			# end

			it "fail token expire" do 
				expired_user = FactoryBot.create(:account)
				expired_token = BuilderJsonWebToken.encode(expired_user.id,1.minutes.ago)
				post current_password_url, params: {
					data: {
						token: expired_token,
						current_password: "ssss"
					}
				}
				expect(response).to have_http_status(422)
				expect(JSON.parse(response.body)['data']).to eq(false)
			end



		end
	end
end