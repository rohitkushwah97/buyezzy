require "swagger_helper"

RSpec.describe "/bx_block_terms_and_conditions", :jwt do
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:role1) { FactoryBot.create(:role, name: "group_admin") }
  let(:role2) { FactoryBot.create(:role, name: "group_basic") }
  let(:account) { create :email_account, role: role1 }
  let(:account2) { create :email_account, role: role2 }

  path "/terms_and_conditions/terms_and_conditions/" do
    post "Create Terms and Condition" do
      tags "bx_block_terms_and_conditions", "terms_and_conditions", "create"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :terms_and_condition, in: :body, schema: {
        type: :object,
        properties: {
          description: {type: :string, example: "description goes here"},
        },
        required: ["description"]
      }

      response "201", "Success" do
        let(:terms_and_condition) { create :terms_and_condition, description: "description goes here", account_id: account.id }
        schema "$ref" => "#/components/schemas/terms_and_condition_id"
        run_test!
      end

      response "401", "Unauthorized" do
        let!(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        let!(:terms_and_condition) { create :terms_and_condition, account_id: account2 }
        schema type: :object,
          properties: {
            message: {type: :string, example: "You are not authorised user or proper role admin"}
          }
        run_test!
      end
    end

    get "List of all terms and conditions" do
      tags "bx_block_terms_and_conditions", "terms_and_conditions", "index"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"

      response "200", "Success" do
        let!(:terms_and_condition) { create :terms_and_condition, description: "description#1", account_id: account.id }
        schema "$ref" => "#/components/schemas/terms_and_condition_list"
        run_test!
      end

      response "404", "Not found" do
        let(:terms_and_condition) { create :terms_and_condition, account_id: account }
        schema type: :object,
          properties: {
            message: {type: :string, example: "terms and conditions data not found"}
          }
        run_test!
      end
    end
  end
end
