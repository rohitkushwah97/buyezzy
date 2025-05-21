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

  path "/bulk_uploading/attachments/{id}" do
    delete "Delete a Bulkuploading" do
      produces 'application/json'
      tags 'bx_block_bulk_uploading', 'bulkuploading', 'delete'
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :id, in: :path, type: :integer
      let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id) }
      let(:id) { attachment.id }
      response "200", :success do
        schema type: :object,
          properties: {
            message: {type: :string}
          }
            run_test! do |response|
             expect(response.status).to eq 200
             json_response = JSON.parse(response.body)
             expect(json_response["message"]).to eq("Deleted.")
            end
      end
    end

    get "show status of bulk uploading" do
      produces 'application/json'
      tags 'bx_block_bulk_uploading', 'bulkuploading', 'show'
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :id, in: :path, type: :integer
      let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id) }
      let(:id) { attachment.id }
      response "200", :success do
        schema type: :object,
          properties: {
            message: {type: :string}
          }
            run_test! do |response|
             expect(response.status).to eq 200
            end
      end

      context "Attachment list should have completed" do
        let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id,status:"completed") }
        let(:id) { attachment.id }
        response "200", :success do
          schema type: :object,
            properties: {
              message: {type: :string}
            }
              run_test! do |response|
               expect(response.status).to eq 200
              end
        end
      end

      context "Attachment list should have failed" do
        let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id,status:"failed") }
        let(:id) { attachment.id }
        response "422", :unprocessable_entity do
          schema type: :object,
            properties: {
              message: {type: :string}
            }
              run_test! do |response|
               expect(response.status).to eq 422
              end
        end
      end
    end
  end
end
