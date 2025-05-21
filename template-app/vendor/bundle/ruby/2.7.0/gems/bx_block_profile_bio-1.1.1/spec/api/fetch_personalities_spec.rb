# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/profile_bio", :jwt do
  let(:account1) { create :email_account, first_name: "first1", last_name: "last1" }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/profile_bio/fetch_personalities" do
    get "Fetch all personalities" do
      tags "fetch_interests"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :search_item, in: :query, type: :string, required: false, example: "extrovert"

      let(:search_item) { "extrovert" }
      response "200", "Fetch all personalities" do
        schema "$ref" => "#/components/schemas/fetch_personalities"
        run_test!
      end
    end
  end
end
