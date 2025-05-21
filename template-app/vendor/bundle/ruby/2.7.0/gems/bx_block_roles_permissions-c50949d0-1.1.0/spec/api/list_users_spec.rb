# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/roles_permissions", :jwt do
  let(:role1) { FactoryBot.create(:role, name: "admin") }
  let(:role2) { FactoryBot.create(:role, name: "basic") }
  let(:account1) { FactoryBot.create(:email_account, role_id: role1.id, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, role_id: role2.id, first_name: "first2", last_name: "last2") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/roles_permissions/accounts/list_users" do
    get "Get list users" do
      tags "list_users"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      response "200", "list of users" do
        schema "$ref" => "#/components/schemas/accounts"
        run_test!
      end

      response "401", "account does not have access" do
        let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        schema type: :object,
          properties: {
            message: {type: :string, example: "account does not have access"}
          }
        run_test!
      end
    end
  end
end
