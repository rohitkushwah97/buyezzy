require "swagger_helper"

RSpec.describe "/bx_block_terms_and_conditions", :jwt do
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:role1) { create :role, name: "group_admin" }
  let(:role2) { create :role, name: "group_basic" }
  let(:account) { create :email_account, role: role1 }
  let(:account2) { create :email_account, role: role2 }

  path "/terms_and_conditions/accept_and_reject" do
    post "Status Of Terms and Condition" do
      tags "bx_block_terms_and_conditions", "user_term_and_conditions", "accept_and_reject"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          terms_and_condition_id: {type: :integer, example: 1 },
          is_accepted: {type: :boolean, example: true }
        },
        required: ["terms_and_condition_id", "is_accepted"]
      }

      response "201", "Success" do
        let(:token) { BuilderJsonWebToken.encode(account2.id) }
        let!(:terms_and_condition) { FactoryBot.create(:terms_and_condition, account_id: account.id) }
        let!(:params) { { terms_and_condition_id: terms_and_condition.id, is_accepted: true } }
        schema "$ref" => "#/components/schemas/user_terms_and_condition"
        run_test!
      end

      response "401", "Unauthorized" do
        let!(:token) { BuilderJsonWebToken.encode(account.id) }
        let!(:terms_and_condition) { FactoryBot.create(:terms_and_condition, account_id: account.id) }
        let!(:params) { { terms_and_condition_id: terms_and_condition.id, is_accepted: true } }
        schema type: :object,
          properties: {
            message: {type: :string, example: "You are not authorised user or proper role basic"}
          }
        run_test!
      end

      response "422", "Invalid Data" do
        let!(:token) { BuilderJsonWebToken.encode(account2.id) }
        let!(:terms_and_condition) { FactoryBot.create(:terms_and_condition, account_id: account.id) }
        let!(:params) { { terms_and_condition_id: terms_and_condition.id, is_accepted: "test" } }
        schema type: :object,
          properties: {
            message: {type: :string, example: "is_accepted should be either true or false."}
          }
        run_test!
      end
    end
  end

  path "/terms_and_conditions/latest_record" do
    get "Get latest record" do
      tags "bx_block_terms_and_conditions", "user_term_and_conditions", "latest_record"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"

      response "200", "Success" do
        let(:token) { BuilderJsonWebToken.encode(account2.id) }
        let!(:terms_and_condition) { FactoryBot.create(:terms_and_condition, account_id: account.id) }
        schema "$ref" => "#/components/schemas/terms_and_condition_latest_record"

        run_test!
      end

      response "401", "Unauthorized" do
        let(:token) { BuilderJsonWebToken.encode(account.id) }
        let!(:terms_and_condition) { FactoryBot.create(:terms_and_condition, account_id: account.id) }
        let!(:user_terms_and_condition) {create :user_terms_and_conditions, is_accepted: true, account_id: account2.id, terms_and_condition_id: terms_and_condition.id }

        schema type: :object,
          properties: {
            message: {type: :string, example: "You are not authorised user or proper role basic"}
          }
        
        run_test!
      end

      response "404", "Not found" do
        let(:token) { BuilderJsonWebToken.encode(account2.id) }
        let(:terms_and_condition) { { description: "description here", account_id: account } }
        schema type: :object,
          properties: {
            message: {type: :string, example: "terms and conditions data not found" }
          }
        run_test!
      end
    end
  end
end
