# frozen_string_literal: true

require_relative '../swagger_helper'

RSpec.describe "/account", :jwt do

  let(:account1) { FactoryBot.create(:email_account, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, first_name: "first2", last_name: "last2") }
  let(:account3) { FactoryBot.create(:email_account, first_name: "first3", last_name: "last3") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }

  path "/account/accounts/search" do
    get "search account" do
      tags "bx_block_Account", "accounts", "index"
      produces "application/json"
      let(:id) { account.id }
      let(:account) { create :email_account }
      let(:token) { BuilderJsonWebToken.encode(account.id) }
      let(:params) { "test" }

      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :query, type: :string, example: "test"
    

      response "200", "Search wise data" do
        schema "$ref" => "#/components/schemas/email_account"
        run_test!
      end
    end
  end
end
