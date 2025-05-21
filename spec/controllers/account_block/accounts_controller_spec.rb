require 'rails_helper'

RSpec.describe AccountBlock::AccountsController, type: :controller do
  let(:new_pass) {"User@321"}
  let(:acc_pass) {"User@123"}
  let(:new_email) {"new_test@email.co"}
  let(:update_name) {'Updated Name'}
  let(:valid_account) { create(:account, password: acc_pass, user_type: 'seller') }
  let(:buyer) { create(:account, password: acc_pass, user_type: 'buyer') }
  let(:catalogue) { create(:catalogue) }
  let(:review) { create(:review, 3, reviewer_id: buyer.id, catalogue: catalogue, account_id: valid_account.id, rating: rating, review_type: 'seller', is_approved: true) }
  let(:token) { BuilderJsonWebToken.encode(valid_account.id) }
  let(:non_existing_id) { 999 }
  let(:not_found) {'Account not found'}
  let(:email_invalid) {'Email invalid'}
  let(:doc_valid_attributes) {
    {
      document_type: "Trading License or Commercial Registration",
      document_name: "License",
      document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "document.pdf"))],
      approved: true
    }
  }

  describe 'POST #create' do

    let(:valid_account_params) do
      {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        company_or_store_name: Faker::Company.name,
        email: Faker::Internet.email,
        full_phone_number: "9190 + #{rand(100000...999999)}",
        password: 'Pass@123',
        confirm_password: 'Pass@123'
      }
    end

    let(:invalid_account_params) do
      valid_account_params.merge({confirm_password: '',full_phone_number: '',password: ''})
    end
    
    context 'with valid parameters' do
      it 'creates a new seller account' do
        post :create, params: {
          data: {
            user_type: 'seller',
            attributes: valid_account_params
          }
        }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to include("Seller and Buyer accounts created successfully")
        expect(JSON.parse(response.body)).to have_key("seller")
        expect(JSON.parse(response.body)).to have_key("buyer")
        expect(JSON.parse(response.body)).to have_key("token")
        expect(JSON.parse(response.body)['seller']['data']['attributes']['email']).to eq(BxBlockActivitylog::ActivityLog.find_by(user_email: valid_account_params[:email]).user_email)
      end

      it 'creates a new seller account with buyer error' do
         buyer_account = create(:account, user_type: 'buyer', activated: true)
         valid_account_params[:email] = buyer_account.email
        post :create, params: {
          data: {
            user_type: 'seller',
            attributes: valid_account_params
          }
        }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to include("Seller account created, but buyer account already exists")
        expect(JSON.parse(response.body)).to have_key("seller")
        expect(JSON.parse(response.body)['errors'][0]).to eq("Email has already been taken")
        expect(JSON.parse(response.body)).to have_key("token")
      end

      it 'creates a new buyer account' do
        post :create, params: {
          data: {
            user_type: 'buyer',
            attributes: valid_account_params
          }
        }

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns errors for invalid attributes' do
        post :create, params: {
          data: {
            user_type: 'seller',
            attributes: invalid_account_params
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors'][0]).to include("Password can't be blank")
      end

       it 'returns errors for invalid match password' do
        invalid_account_params[:confirm_password] = "asd123hfgk"
        invalid_account_params[:password] = "asd1hfgk"
        post :create, params: {
          data: {
            user_type: 'seller',
            attributes: invalid_account_params
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors'][0]['accounts']).to include("Password and confirm password should be the same")
      end
    end

    context 'with existing account email' do
      let!(:existing_account) { create(:account, email: valid_account_params[:email], user_type: 'buyer', activated: true) }

      it 'returns an error' do
        post :create, params: {
          data: {
            user_type: 'buyer',
            attributes: valid_account_params
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors'][0]).to eq("Email has already been taken")
      end
    end

    context 'with unknown user type' do
      it 'returns an error' do
        post :create, params: {
          data: {
            user_type: 'unknown',
            attributes: valid_account_params
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors'][0]['accounts']).to eq('Unknown user type')
      end
    end
  end

  describe 'GET #account_activation' do

    context 'when a valid token is provided' do
      let(:account) { FactoryBot.create(:account, user_type: 'seller', activated: false) }
      let(:valid_token) { BuilderJsonWebToken.encode(account.id) }

      before do
        @buyer_account = FactoryBot.create(:account, user_type: 'buyer', email: account.email, activated: false)
        get :account_activation, params: { token: valid_token }
        account.reload
        @buyer_account.reload
      end

      it 'activates the account' do
        expect(account.activated).to be true
        json_response = JSON.parse(response.body)
        expect(json_response['meta']).to have_key('token')
        expect(@buyer_account.activated).to be true
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it 'invalid activation link' do
        get :account_activation, params: { token: valid_token }
        body = JSON.parse(response.body)
        expect(body['errors']).to eq('Invalid activation link. Please try again or contact support.')
        expect(response).to have_http_status(:ok)
      end

    end

    context 'when an invalid token is provided' do
      it 'returns an error for invalid token' do
        get :account_activation, params: {  }
        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors']).to eq('Invalid token')
      end
    end
  end

  describe 'GET #show' do
    it 'returns the account details' do
      get :show, params: { id: valid_account.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(valid_account.full_name)
      expect(response.body).to include(valid_account.email)
    end

    it 'returns an error if the account is not found when show' do
      get :show, params: { id: non_existing_id }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include(not_found)
    end
  end

  describe 'PATCH #update' do
    let(:valid_attributes) { { full_name: update_name, email: valid_account.email } }
    let(:invalid_attributes) { { email: 'invalid_email' } }

    it 'updates the account with valid attributes' do
      patch :update, params: { id: valid_account.id, data: { attributes: valid_attributes } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to include("Profile updated successfully!")
      expect(valid_account.reload.full_name).to eq(update_name)
    end

    it 'updates the account with valid full_name' do
      patch :update, params: { id: valid_account.id, data: { attributes: valid_attributes.except(:email) } }
      expect(JSON.parse(response.body)['message']).to include("Seller name updated successfully!")
    end

    it 'updates the account with valid company_or_store_name' do
      patch :update, params: { id: valid_account.id, data: { attributes: { company_or_store_name: 'store1name' } } }
      expect(JSON.parse(response.body)['message']).to include("Store name updated successfully!")
    end

    it 'updates the account with valid first name' do
      patch :update, params: { id: valid_account.id, data: { attributes: { first_name: 'first1name' } } }
      expect(JSON.parse(response.body)['message']).to include("First name updated successfully!")
    end

    it 'updates the account with valid password' do
      patch :update, params: { id: valid_account.id, data: { attributes: {current_password: acc_pass,new_password: new_pass } } }
      expect(response).to have_http_status(:ok)
      expect(BCrypt::Password.new(valid_account.reload.password_digest)).to eq(new_pass)
      expect(JSON.parse(response.body)['message']).to include("Password updated successfully!")
    end

    it 'returns an error if the account is not found when update' do
      patch :update, params: { id: non_existing_id, data: { attributes: valid_attributes } }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include(not_found)
    end

    it 'returns an error if the attributes are invalid' do
      patch :update, params: { id: valid_account.id, data: { attributes: invalid_attributes } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include(email_invalid)
    end

    it 'returns an error if the new password and confirm password do not match' do
      attributes = { current_password: 'password123', new_password: 'password456' }
      patch :update, params: { id: valid_account.id, data: { attributes: attributes } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Incorrect current password')
    end

    it 'returns an error if the email already exists' do
      existing_account = create(:account, email: 'existing@example.com')
      attributes = { email: 'existing@example.com' }
      patch :update, params: { id: valid_account.id, data: { attributes: attributes } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include(email_invalid)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the account' do
      delete :destroy, params: { id: valid_account.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Account deleted successfully')
      expect { AccountBlock::Account.find(valid_account.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error if the account is not found when destroy' do
      delete :destroy, params: { id: non_existing_id }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include(not_found)
    end
  end

  describe 'POST resend_email' do

    before do
      post :resend_email, params: { token: token }
    end

    it 'resends the activation email' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a success message' do
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Activation email has been resent')
    end
  end

  describe 'GET logged_user' do
    context 'when the account exists' do
      it 'returns the logged user account details' do
        get :logged_user, params: { token: token }
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(AccountBlock::AccountSerializer.new(valid_account).serializable_hash.to_json)
      end
    end

    it 'returns an no doc status' do
      review = create(:review, reviewer_id: buyer.id, catalogue: catalogue, account_id: valid_account.id, rating: 4, review_type: 'seller', is_approved: true)
      get :logged_user, params: { token: token}
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['document_status']).to eq("No documents uploaded")
      expect(json_response['data']['attributes']['seller_rating']['total_reviews']).to eq(1)
      expect(json_response['data']['attributes']['first_time_login']).to eq(false)
    end

    it 'returns an approved doc status approved' do
      doc = AccountBlock::SellerDocument.create!(doc_valid_attributes.merge(account_id: valid_account.id))
      get :logged_user, params: { token: token}
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['document_status']).to eq("Your document has been verified")
    end

    it 'returns an approved doc status inprogress' do
      doc_valid_attributes[:approved] = false
      doc_valid_attributes[:rejected] = false
      doc2 = AccountBlock::SellerDocument.create!(doc_valid_attributes.merge(account_id: valid_account.id))
      get :logged_user, params: { token: token}
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['document_status']).to eq("Your Document verification is in progress")
    end

    it 'returns an approved doc status rejected' do
      doc_valid_attributes[:document_type] = "Residence visa for non-nationals"
      doc_valid_attributes[:approved] = false
      doc_valid_attributes[:rejected] = true
      doc1 = AccountBlock::SellerDocument.create!(doc_valid_attributes.merge(account_id: valid_account.id))
      get :logged_user, params: { token: token}
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['document_status']).to eq("Rejected: License")
    end
  end

  describe "POST upload_image" do
    context "with image file attaches" do
      let(:account) { FactoryBot.create(:account, activated: true) }
      let(:valid_token) { BuilderJsonWebToken.encode(account.id) }

      it "attaches the profile picture to the account" do
        image_data = fixture_file_upload('files/Sample.jpg', 'image/jpeg') 
        post :upload_image, params: { token: valid_token, profile_picture: image_data }
        expect(account.reload.profile_picture).to be_attached
      end

      it "should remove attached the profile picture from account when no image provided" do
        post :upload_image, params: { token: valid_token }
        expect(account.reload.profile_picture).not_to be_attached
      end
    end
  end
end
