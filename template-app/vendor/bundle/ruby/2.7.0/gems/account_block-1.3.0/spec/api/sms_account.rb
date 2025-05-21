require "swagger_helper"

RSpec.describe "/account", :jwt do
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }

  path "/account/accounts" do
    post "Create a SMS account" do
      tags "bx_block_SMS Account", "SMS Account", "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              full_phone_number: {type: :string},
              password: {type: :string}
            }
          }
        },
        required: ["full_phone_number","password"]
      }
      let(:params) {
        {
          data: {
            type: "sms_account",
            attributes: {
              email: full_phone_number,
              password: "password"
            }
          }
        }
      }

      let(:full_phone_number) { "email@acme.com" }
      context "given an invalid full_phone_number" do
        response "422", :unprocessable_entity do
          schema "$ref" => "#/components/schemas/sms_account"
          let(:full_phone_number) { "email@acme" }

          before do |example|
            submit_request(example.metadata)
          end

          it "returns a 422" do
            expect(response.status).to eq 422
            expect(json["errors"].count).to be > 0
          end
        end
      end
    end
  end
end  
