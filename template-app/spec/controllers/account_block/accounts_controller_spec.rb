require 'rails_helper' 
require 'simplecov'
RSpec.describe AccountBlock::AccountsController, type: :request do
  let(:user1) { FactoryBot.create(:intern_user, activated: true) }
  let(:user2) { FactoryBot.create(:business_user) }
  let(:url) { "/account_block/resend_email"}
  let(:url_account_deletion) { "/account_block/account_deletion"}
  let(:url_delete) { "/account_block/delete_user"}
  let(:user) { FactoryBot.create(:intern_user, activated: true) }
  let(:token) do
    BuilderJsonWebToken::JsonWebToken.encode(user.id)
  end
  let(:headers) do
    { 'token' => "#{token}" }
  end

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  context "POST /resend email" do
    it "should send verify email successfully" do
      post url, params: { email: user2.email }, headers: headers
      expect(response).to have_http_status(200)
      expect(json_response["message"]).to eql("Email sent successfully.")
    end

    it "should return message 'email already verified'" do
      post url, params: { email: user1.email }, headers: headers
      expect(response).to have_http_status(422)
      expect(json_response["message"]).to eql("Email is already verified.")
    end

    it "should return error 'email does not exist'" do
      post url, params: { email: "test@gmail.commm" }, headers: headers
      expect(response).to have_http_status(404)
      expect(json_response["error"]).to eql("Email does not exist.")
    end
  end

  describe 'DELETE #delete_user' do
    context 'when account deletion is successful' do
      it 'returns a success message' do
        delete url_delete, headers: headers # Pass the headers with the delete request
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Account deleted successfully.')
      end
    end
  end

  describe 'GET #account_deletion' do
    context 'account deletion html page' do
      it 'returns a success account deletion page' do
        get url_account_deletion
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('User Account Deletion')
      end
    end
  end

  describe 'GET #details' do
    let(:account) { FactoryBot.create(:business_user) }
    it 'returns the specific FAQ' do
      get account_block_account_details_path(account.id)
      # expect(response).to have_http_status(:ok)
    end
  end
end
# 