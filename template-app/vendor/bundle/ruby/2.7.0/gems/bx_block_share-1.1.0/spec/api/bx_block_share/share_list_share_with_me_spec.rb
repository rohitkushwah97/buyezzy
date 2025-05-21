require "swagger_helper"

RSpec.describe "share/share", :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let!(:account) { create :email_account, user_name: "test_1" }
  let(:id) { account.id }
  let(:token) { BuilderJsonWebToken.encode(account.id) }

  path "/share/share" do
    get "List share items" do
      consumes 'application/json'
      produces "application/json"
      tags 'bx_block_share', 'share', 'list share items'
      tags "Share"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true

      let!(:account2) { create :email_account, user_name: "test_2" }
      let!(:post1) { create(:post, description: "test") }
      let!(:params) { {data: {shared_to_id: account2.id, post_id: post1.id}} }
      let!(:share) { create(:share, account: account, post: post1, shared_to_id: account2.id) }

      context "given valid parameters" do
        response "200", :success do
       
          context 'List Share Items' do
            run_test! do |response|
            expect(BxBlockShare::Share.count).to eq 1
          end
        end
        end
      end

      context "given an expired token" do
        response "401", :unauthorized do
          let(:token) { jwt_expired }
          context 'indicates that the token has expired' do
            run_test! do |response|
            expect(error["token"]).to match(/expired/i)
          end
        end
        end
      end

      context "given an invalid token" do
        response "400", :unauthorized do
          let(:token) { "invalid_token" }
          context 'indicates that the record was not found' do
            run_test! do |response|
  
            expect(error).to match({"token" => "Invalid token"})
          end
        end
        end
      end
    end
  end

  path "/share/share/shared_with_me" do
    get "List share items with me" do
      consumes 'application/json'
      produces "application/json"
      tags 'bx_block_share', 'share', 'share items with me'
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true

      let!(:account2) { create :email_account, user_name: "test_2" }
      let!(:post1) { create(:post, description: "test") }
      let!(:params) { {data: {shared_to_id: account2.id, post_id: post1.id}} }
      let!(:share) { create(:share, account: account, post: post1, shared_to_id: account2.id) }

      context "given valid parameters" do
        response "200", :success do
          before do |example|
            submit_request(example.metadata)
          end
          context 'List Share Items With Me' do
            run_test! do |response|
            expect(BxBlockShare::Share.count).to eq 1
          end
        end
        end
      end

      context "given an expired token" do
        response "401", :unauthorized do
          let(:token) { jwt_expired }
          context 'indicates that the token has expired' do
            run_test! do |response|
            expect(error["token"]).to match(/expired/i)
          end
        end
        end
      end

      context "given an invalid token" do
        response "400", :unauthorized do
          let(:token) { "invalid_token" }
          context 'indicates that the record was not found' do
            run_test! do |response|
            expect(error).to match({"token" => "Invalid token"})
          end
        end
        end
      end
    end
  end
end
