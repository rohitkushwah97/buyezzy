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

  path "/bulk_uploading/attachments" do
    post "Create Bulk Uploading" do
      consumes "multipart/form-data"
      tags "bx_block_bulk_uploading", "bulkuploading", "create"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :files, in: :formData, required: true
      response "201", :Created do
        schema "$ref" => "#/components/schemas/attachments"
        let(:files) { Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/test.pdf")) }
        run_test! do |response|
          expect(response.status).to eq 201
          json_response = JSON.parse(response.body)
          expect(json_response["meta"]["message"]).to eq("Attachment Created Successfully")
        end
      end

      response "422", :unprocessable_entity do
        let(:files) do
          101.times.map do
            Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/test.pdf"))
          end
        end
        run_test! do |response|
          expect(response.status).to eq 422
          json_response = JSON.parse(response.body)
          expect(response.body).to include "total number is out of range"
        end
      end

      response "422", "Size > 5MB" do
        let(:files) { [Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/5_4mb.jpeg"))] }
        run_test! do |response|
          expect(response.status).to eq 422
          json_response = JSON.parse(response.body)
          expect(response.body).to include "Size of individual file should be less than 5 MB"
        end
      end

      response "201", "Size < 5MB" do
        let(:files) { [Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/4_9mb.jpeg"))] }
        schema "$ref" => "#/components/schemas/attachments"
        run_test! do |response|
          expect(response.status).to eq 201
        end
      end

      response "201", "individual size < 5MB; total size > 5MB" do
        let(:files) do
          [
            Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/4_9mb.jpeg")),
            Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/2_0mb.jpeg"))
          ]
        end
        schema "$ref" => "#/components/schemas/attachments"
        run_test! do |response|
          expect(response.status).to eq 201
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

    get "Get Bulk Uploading" do
      produces "application/json"
      tags "bx_block_bulk_uploading", "bulkuploading", "index"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id, files: files) }
      response "200", :success do
        schema "$ref" => "#/components/schemas/get_attachments"
        run_test! do |response|
          expect(response.status).to eq 200
          json_response = JSON.parse(response.body)
          expect(json_response[0]["data"]["attributes"]["files"][0]["file_name"]).to eq files[0].original_filename
        end
      end

      context "Attachment list should have completed" do
        let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id, files: files, status: "completed") }
        response "200", :success do
          schema type: :array, properties: {
            data: {
              id: :integer,
              type: :string,
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer},
                  account_id: {type: :integer},
                  files: :object,
                  properties: {
                    id: :integer,
                    file_name: :string,
                    file_url: :string
                  },
                  status: :string
                }
              }
            }
          }
          run_test! do |response|
            expect(response.status).to eq 200
            json_response = JSON.parse(response.body)
            expect(json_response[0]["data"]["attributes"]["files"][0]["file_name"]).to eq files[0].original_filename
          end
        end
      end

      context "Attachment list should not have  status" do
        let!(:attachment) { FactoryBot.create(:attachment, account_id: account.id, files: files, status: "failed") }
        response "200", :success do
          schema type: :array, properties: {
            data: {
              id: :integer,
              type: :string,
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer},
                  account_id: {type: :integer},
                  files: :object,
                  properties: {
                    id: :integer,
                    file_name: :string,
                    file_url: :string
                  },
                  status: :string
                }
              }
            }
          }
          run_test! do |response|
            expect(response.status).to eq 200
            json_response = JSON.parse(response.body)
            expect(json_response[0]["data"]["attributes"]["files"][0]["file_name"]).to eq files[0].original_filename
          end
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
end
