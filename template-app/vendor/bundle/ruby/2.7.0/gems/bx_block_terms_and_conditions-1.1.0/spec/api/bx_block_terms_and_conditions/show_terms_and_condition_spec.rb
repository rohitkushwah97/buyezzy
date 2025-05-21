require "swagger_helper"

RSpec.describe "/bx_block_terms_and_conditions", :jwt do
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:role1) { create :role, name: "group_admin" }
  let(:role2) { create :role, name: "group_basic" }
  let(:account) { create :email_account, role: role1 }
  let(:account2) { create :email_account, role: role2 }

  path "/terms_and_conditions/terms_and_conditions/{terms_and_conditions_id}" do
    get "Show Terms and Conditions" do
      tags "bx_block_terms_and_conditions", "terms_and_conditions", "show"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      parameter name: :terms_and_conditions_id, in: :path, type: :integer, example: 1, required: true

      response "200", "Success" do
        let!(:token) { BuilderJsonWebToken.encode(account.id) }
        let!(:terms_and_condition) { FactoryBot.create(:terms_and_condition, account_id: account.id) }
        let(:terms_and_conditions_id) { terms_and_condition.id }
        schema "$ref" => "#/components/schemas/terms_and_condition"
        run_test!
      end

      response "401", "Unauthorized" do
        let!(:token) { BuilderJsonWebToken.encode(account2.id) }
        let!(:terms_and_condition) { FactoryBot.create(:terms_and_condition, account_id: account.id) }
        let(:terms_and_conditions_id) { terms_and_condition.id }
        let!(:params) { { id: terms_and_condition.id, is_accepted: true} }
        schema type: :object,
          properties: {
            message: {type: :string, example: "You are not authorised user or proper role admin"}
          }
        run_test!
      end

      response "422", "Invalid id" do
        let!(:token) { BuilderJsonWebToken.encode(account.id) }
        let(:terms_and_condition) { { description: "here goes the description", account_id: account } }
        let(:terms_and_conditions_id) { -1 }
        schema type: :object,
          properties: {
            message: {type: :string, example: "Please provide valid id" }
          }
        run_test!
      end

      response "404", "Not found" do
        let!(:token) { BuilderJsonWebToken.encode(account.id) }
        let(:terms_and_condition) { { description: "here goes the description", account_id: account } }
        let(:terms_and_conditions_id) { 1 }
        schema type: :object,
          properties: {
            message: {type: :string, example: "terms and conditions data not found" }
          }
        run_test!
      end
    end
  end
end
