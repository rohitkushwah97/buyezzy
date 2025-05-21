require "swagger_helper"

RSpec.describe "/bx_block_data_import_export", :jwt do
  let(:headers) { {token: token} }

  let(:response_body) { response.body }
  let(:json_data) { JSON response.body }
  let(:data) { response_body["data"] }
  let(:token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { response_body["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }

  let(:account) { create :email_account, user_name: "test_12" }
  let(:id) { account.id }
  let!(:account2) { create :email_account, user_name: "test_123" }
  let!(:account3) { create :email_account, user_name: "test_1234" }
  let!(:account4) { create :email_account, user_name: "test_12345" }
  let!(:account5) { create :email_account, user_name: "test_123456" }

 

  path "/data_import_export/export" do
    get "Data Export" do
      tags "bx_block_data_import_export", "Data Import Export", "index"
      produces 'application/csv'
      description '''Export data in different formats: 
                     Export data in json, send content-type: json in request header
                     Export data in csv, send content-type: csv in request header'''
      produces "application/json", "application/text"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: "Content-Type", in: :header, schema: {
        oneOf: [ 
          {type: :string, example: "text/json"},
          {type: :string, example: "text/csv"},
        ]
      }

      let(:observed_response_json) do
        {
          "id" => account2.id.to_s,
          "type" => "account",
          "attributes" => {
            "activated" => account2.activated,
            "country_code" => account2.country_code,
            "email" => account2.email,
            "first_name" => account2.first_name,
            "full_phone_number" => account2.full_phone_number,
            "last_name" => account2.last_name,
            "phone_number" => account2.phone_number,
            "type" => account2.type,
            "created_at" => account2.created_at.as_json,
            "updated_at" => account2.updated_at.as_json
          }
        }
      end

      response "200", :success do
        schema oneOf: [{ '$ref' => "#/components/schemas/data_import_export_json" }, { '$ref' => '#/components/schemas/data_import_export_csv' }, ]
        context "returns list of account in csv" do
          let("Content-Type") { "text/csv" }

          run_test! do |response|
            expect(response_body)
              .to include("test_12", "test_123", "test_1234", "test_12345", "test_123456")
          end
        end
        context "returns list of account in json" do
          let("Content-Type") { "text/json" }

          run_test! do |response|
            expect(json_data["data"].count).to eq(5)
            expect(json_data["data"][0]).to eq(observed_response_json)
          end
        end
      end
    end
  end
end
