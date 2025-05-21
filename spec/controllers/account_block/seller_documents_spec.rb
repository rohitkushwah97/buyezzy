require 'rails_helper'

RSpec.describe AccountBlock::SellerDocumentsController, type: :request do
  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @seller = create(:account, user_type: "seller")
    @token_s = BuilderJsonWebToken.encode(@seller.id, token_type: 'login')
  end

  let(:valid_attributes) {
    {
      document_type: "Trading License or Commercial Registration",
      document_name: "License",
      document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "document.pdf"))]
    }
  }

  let(:invalid_attributes) {
    {
      document_type: "Trading License or Commercial Registration",
      document_name: "License"
    }
  }

  describe "GET /index" do

    it "index renders a successful response" do
      AccountBlock::SellerDocument.create!(valid_attributes.merge(account_id: @account.id))
      get "/account_block/accounts/#{@account.id}/seller_documents", headers: { token: @token }
      expect(response).to be_successful
    end

  end

  describe "GET /show" do
    it "show renders a successful response" do
      seller_document = AccountBlock::SellerDocument.create!(valid_attributes.merge(account_id: @account.id))
      get "/account_block/accounts/#{@account.id}/seller_documents/#{seller_document.id}", headers: { token: @token }
      expect(response).to be_successful
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("document_files")
    end

    it "show renders a error response" do
      get "/account_block/accounts/#{@seller.id}/seller_documents/999" , params: { token: @token_s }
      expect(JSON.parse(response.body)["errors"]).to eq("No Seller Document found")      
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SellerDocument" do
        expect {
          post "/account_block/accounts/#{@account.id}/seller_documents", params: valid_attributes, headers: { token: @token }
        }.to change(AccountBlock::SellerDocument, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new SellerDocument" do
        expect {
          post "/account_block/accounts/#{@account.id}/seller_documents", params: invalid_attributes, headers: { token: @token }
        }.to change(AccountBlock::SellerDocument, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "update with valid parameters" do
      let(:new_attributes) {
        {
          document_name: "New Name"
        }
      }

      it "updates the requested seller_document" do
        seller_document = AccountBlock::SellerDocument.create!(valid_attributes.merge(account_id: @account.id))
        patch "/account_block/accounts/#{@account.id}/seller_documents/#{seller_document.id}", params: new_attributes, headers: { token: @token }
        seller_document.reload
        expect(seller_document.document_name).to eq("License")
      end
    end
  end

  describe "POST /document_verification_email" do
    context "with valid parameters document_verification_email" do

      it "user not found" do
        post "/account_block/accounts/document_verification_email", params: { token: @token, admin_email: 'admin@byezzy.com' }
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        expect(JSON.parse(response.body)["message"]).to eq("User not found")
      end

      it "send email to vender / admin" do
        post "/account_block/accounts/document_verification_email", params: { token: @token_s }
        expect(ActionMailer::Base.deliveries.count).to eq(2)
        expect(JSON.parse(response.body)["message"]).to eq("Document verification email sent")
      end
    end
  end
end
