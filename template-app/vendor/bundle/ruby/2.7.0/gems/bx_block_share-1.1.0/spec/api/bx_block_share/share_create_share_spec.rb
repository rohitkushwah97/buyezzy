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

  path "/share/share/twitter" do
    post "share twitter" do
      consumes "application/json"
      produces "application/json"
      tags "bx_block_share", "share", "share twitter"
      let!(:base_url) { "0.0.0.0:3000" }
      let!(:post1) { create(:post, description: "test") }
      let!(:post_url) { "#{base_url}/bx_block_posts/posts/#{post1.id}" }

      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: "params", in: :body
      let!(:params) { {url: post_url, token: token} }

      response "200", :success do
        schema "$ref" => "#/components/schemas/share_url"
        context "given valid parameters" do
          run_test! do |response|
            expect(response.content_type).to eq("application/json; charset=utf-8")
            expect(response).to have_http_status(200)
            expect(json["message"]).to eq "https://twitter.com/intent/tweet?text=#{base_url}/bx_block_posts/posts/#{post1.id}"
          end
        end
      end
      response "401", :unprocessable_entity do
        let(:token) { jwt_expired }
        run_test! do |response|
          expect(response.status).to eq 401
          expect(error["token"]).to match(/expired/i)
        end
      end

      response "400", :unauthorized do
        let(:token) { "" }
        run_test!
      end
      response "401", :unauthorized do
        let(:token) { jwt_expired }
        run_test!
      end
    end
  end

  path "/share/share" do
    post "Create share items" do
      consumes "application/json"
      produces "application/json"
      tags "bx_block_share", "share", "create share items"
      let!(:account2) { create :email_account, user_name: "test_2" }
      let!(:post1) { create(:post, description: "test") }
      let(:params) { {data: {shared_to_id: account2.id, post_id: post1.id}} }

      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: "params", in: :body

      context "given valid parameters" do
        response "200", :success do
          schema "$ref" => "#/components/schemas/share_item"
          context "Get new share records" do
            run_test! do |response|
              expect(response.status).to eq 200
              expect(attributes["post_id"]).to eq post1.id
              expect(attributes["account_id"]).to eq account.id
              expect(attributes["shared_to_id"]).to eq account2.id
            end

            context "Has documents data in the response" do
              let(:params) {
                {
                  data: {
                    shared_to_id: account2.id,
                    documents: [
                      {
                        data: Base64.strict_encode64(File.read(Rails.root.join("app", "assets", "files", "tiny_pdf.pdf"))),
                        filename: "tiny_pdf.pdf",
                        content_type: "application/pdf"
                      },
                      {
                        data: Base64.strict_encode64(File.read(Rails.root.join("app", "assets", "images", "doc_photo.jpg"))),
                        filename: "doc_image.jpg",
                        content_type: "image/jpeg"
                      }
                    ]
                  }
                }
              }
              run_test! do |response|
                expect(response.status).to eq 200
                expect(attributes["documents"].count).to eq 2
                expect(attributes["documents"].find { |doc| doc["filename"] == "tiny_pdf.pdf" }["url"].empty?).to eq false
                expect(attributes["documents"].find { |doc| doc["filename"] == "doc_image.jpg" }["url"].empty?).to eq false
              end
            end
          end
        end
      end
    end
  end
end
