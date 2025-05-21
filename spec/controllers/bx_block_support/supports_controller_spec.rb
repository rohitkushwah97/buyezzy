require 'rails_helper'

RSpec.describe BxBlockSupport::SupportsController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end

  describe "POST /create" do

    context "with valid parameters" do
      it "creates a new Support" do
        post :create,
        params: { "token": @token,
          "data": {
            "attributes": {
              "first_name": "test",
              "last_name": "user",
              "email": Faker::Internet.email,
              "details": "ajdddddddajdsssssssssssnbcxxksaudik"
            }
          }
        }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the new support" do
        post :create,
        params: { "token": @token,
          "data": {
            "attributes": {
              "first_name": "test",
              "last_name": "user",
              "email": "jdssssssssss",
              "details": "ajdddddddajdsssssssssssnbcxxksaudik"
            }
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors'][0]['account']).to include("Email invalid")
      end
    end

  end

end
