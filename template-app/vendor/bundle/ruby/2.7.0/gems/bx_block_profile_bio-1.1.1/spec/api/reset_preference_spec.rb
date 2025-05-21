# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/profile_bio", :jwt do
  let(:account1) { create :email_account, first_name: "first1", last_name: "last1", activated: true }
  let(:account2) { create :email_account, first_name: "first2", last_name: "last2" }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/profile_bio/preferences/reset_preference" do
    get "Reset Prefence" do
      tags "reset_preference"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      response "200", "Reset Prefence successfully" do
        let!(:preference1) { create :preference, account_id: account1.id }

        schema "$ref" => "#/components/schemas/reset_preference"
        run_test!
      end

      response "404", "Preference not found" do
        let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        schema type: :object,
          properties: {
            message: {type: :string, example: "Preference not found"}
          }
        run_test!
      end
    end
  end
end
