# frozen_string_literal: true

require "swagger_helper"
include ActionDispatch::TestProcess
RSpec.describe "/bx_block_bulk_uploading", :jwt do
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:account) { create :email_account }
  let(:id) { account.id }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let(:new_image) { blob_for("support/image_test_new.jpg").signed_id }
  let(:files) { [Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/test.pdf"))] }

  path "/bulk_uploading/attachments/delete_attachment/{id}/{file_id}" do
    delete "Delete specific file" do
      consumes "application/json"
      produces "application/json"
      tags "bx_block_bulk_uploading", "bulkuploading", "delete"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer
      parameter name: :file_id, in: :path, type: :integer
      let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id, files: files) }
      let(:id) { attachment.id }
      let(:file_id) { ActiveStorage::Attachment.first.id }
      response "200", :success do
        schema type: :object,
          properties: {
            message: {type: :string}
          }
        run_test! do |response|
          expect(response.status).to eq 200
          json_response = JSON.parse(response.body)
          expect(json_response["message"]).to eq("Attachment file deleted successfully.")
        end
      end

      context "Attachment file does not exist with this account" do
        response "422", :unprocessable_entity do
          let(:account2) { create :email_account }
          let(:token) { BuilderJsonWebToken.encode(account2.id) }
          let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id, files: files) }
          let(:id) { attachment.id }
          run_test! do |response|
            expect(response.status).to eq 422
            json_response = JSON.parse(response.body)
            expect(json_response["message"]).to eq("Attachment file does not exist with this account")
          end
        end
      end
    end
  end
end
