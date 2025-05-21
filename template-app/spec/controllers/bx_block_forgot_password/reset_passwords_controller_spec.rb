require 'rails_helper'

RSpec.describe BxBlockForgotPassword::ResetPasswordsController, type: :controller do
  PASSWORD = "Password@123".freeze

  account = FactoryBot.create(:user)
  let(:token) { BuilderJsonWebToken.encode(account.id, 24.hours.from_now) }
  let!(:new_token) { BuilderJsonWebToken.encode(account.id, 24.hours.from_now) }

  describe 'POST #create' do
    context 'when account exists' do
      it 'sends a reset password email' do
        expect {
          post :create, params: { email: account.email }
        }.to change { ActionMailer::Base.deliveries.count }.by(1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("An email has been sent for reset password, please check!")

        mail = ActionMailer::Base.deliveries.last
        expect(mail.to).to eq([account.email])
        expect(mail.subject).to eq("Reset Password")
      end
    end

    context 'when account does not exist' do
      it 'returns an error' do
        post :create, params: { email: "wrong@example.com" }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]["message"]).to eq("Account not Found")
      end
    end
  end

  describe 'PUT #update' do
    before do
      allow(controller).to receive(:validate_token).and_return(true)
      account.update(token: token)
    end

    context 'when passwords match and are valid' do
      it 'updates the valid password' do
        put :update, params: { token: token, reset_password: { password: "NewPassword123!", confirm_password: "NewPassword123!" } }
        account.reload
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("password updated successfully!")
      end
    end
    
    context 'when passwords match and are invalid' do
      it 'updates the nil password' do
        put :update, params: { token: token, reset_password: { password: nil } }
        account.reload
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]["message"]).to eq("password can't be blank, please add a valid password")
      end
    end

    context 'update password with the invalid password' do
      it '#updates' do
        put :update, params: { token: token, reset_password: { password: "password1234", confirm_password: "password1234" } }
        account.reload
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]["message"]).to eq("password"=>["Minimum 8 characters, maximun 20 characters, atleast one capital letter, atleast one number and atleast one special character"])
      end
    end
  end

  describe 'when account with invalid token' do
    before do
      account.update(token: "qwer")
    end
    context 'create account with invalid token' do
      it 'updates the password' do
        put :update, params: { token: token, reset_password: { password: PASSWORD }}
        account.reload
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["errors"]["message"]).to eq("Token has Expired")
      end
    end
    context 'create account with invalid token' do
      it 'updates the password' do
        put :update, params: {reset_password: {password: PASSWORD }}
        account.reload
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["errors"]["message"]).to eq("please pass a valid Token")
      end
    end
  end
end
