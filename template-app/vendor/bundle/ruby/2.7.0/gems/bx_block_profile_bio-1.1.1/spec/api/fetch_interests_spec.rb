# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/profile_bio", :jwt do
  let(:account1) { create :email_account, first_name: "first1", last_name: "last1" }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/profile_bio/fetch_interests" do
    get "Fetch all interests" do
      tags "fetch_interests"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :search_item, in: :query, type: :string, required: false, example: "fitness"

      let(:search_item) { "fitness" }
      response "200", "Fetch all interests" do
        schema "$ref" => "#/components/schemas/fetch_interests"
        run_test!
      end
    end
  end
end
