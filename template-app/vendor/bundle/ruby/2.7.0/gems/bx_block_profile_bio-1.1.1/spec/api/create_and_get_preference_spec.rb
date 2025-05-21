# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/profile_bio", :jwt do
  let(:account1) { create :email_account, first_name: "first1", last_name: "last1", activated: true }
  let(:account2) { create :email_account, first_name: "first2", last_name: "last2" }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/profile_bio/preferences" do
    post "Create a Prefence" do
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
              type: :object,
              properties: {
                  "seeking": {type: :string, example: "Male" },
                  "location": {type: :string, example: "test" },
                  "distance": {type: :integer, example: 50 },
                  "age_range_start": {type: :integer, example: 27 },
                  "age_range_end": {type: :integer, example: 39 },
                  "height_range_start": {type: :string, example: "5" },
                  "height_range_end": {type: :string, example: "6" },
                  "height_type": {type: :string, example: "foot" },
                  "body_type": {type: :string, example: "Athletic" },
                  "religion": {type: :string, example: "Jain" },
                  "smoking": {type: :string, example: "No" },
                  "drinking": {type: :string, example: "No" },
                  "friend": {type: :boolean, example: true },
                  "business": {type: :boolean, example: true },
                  "match_making": {type: :boolean, example: true },
                  "travel_partner": {type: :boolean, example: true },
                  "cross_path": {type: :boolean, example: true },
                  "is_paid": {type: :boolean, example: false }
                }
              }
            }
          }
        }
      }

      response "201", "Prefence created successfully" do
        let(:preference1) { create :preference, account_id: account1.id }
        let(:params) do
          {
            data:{
              attributes: {
                "seeking": "Male",
                "distance": 50,
                "age_range_start": 27,
                "age_range_end": 39,
                "height_range_start": "5",
                "height_range_end": "6",
                "height_type": "foot",
                "body_type": "Athletic",
                "religion": "Jain",
                "smoking": "No",
                "drinking": "No",
                "friend": true,
                "business": true,
                "match_making": true,
                "travel_partner": true,
                "cross_path": true,
                "is_paid": false
              }
            }
          }
        end
        schema "$ref" => "#/components/schemas/preference"
        run_test!
      end

      response "422", "Preference has been already created or invalid parms" do
        let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

        context "Preference has been already created" do
          let!(:preference1) { create :preference, account_id: account1.id }
          let(:params) do
          {
            data:{
              attributes: {
                "seeking": "Male",
                "location": "test",
                "distance": 50,
                "age_range_start": 27,
                "age_range_end": 39,
                "height_range_start": "5",
                "height_range_end": "6",
                "height_type": "foot",
                "body_type": "Athletic",
                "religion": "Jain",
                "smoking": "No",
                "drinking": "No",
                "friend": true,
                "business": true,
                "match_making": true,
                "travel_partner": true,
                "cross_path": true,
                "is_paid": false
              }
            }
          }
          end
          schema type: :object,
            properties: {
              errors: {
                type: :array,
                items: {
                  type: :object
                },
                example: [
                  "profile": "Preference has been already created"
                ]
              }
            }
          run_test!
        end

        context "pass invalid params" do
          let(:params) do
          {
            data:{
              attributes: {
                "seeking": "Male1",
                "location": "test11",
                "distance": 50,
                "age_range_start": 27,
                "age_range_end": 39,
                "height_range_start": "5",
                "height_range_end": "6",
                "height_type": "foot",
                "body_type": "Athletic",
                "religion": "Jain",
                "smoking": "No",
                "drinking": "No",
                "friend": true,
                "business": true,
                "match_making": true,
                "travel_partner": true,
                "cross_path": true,
                "is_paid": false
              }
            }
          }
          end
          schema type: :object,
            properties: {
              errors: {
                type: :array,
                items: {
                  type: :object
                },
                example: [
                  "preference": "'Male1' is not a valid seeking"
                ]
              }
            }
          run_test!
        end
      end
    end

    get "Get a profile preferences" do
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      response "200", "get a profile preferences" do
        let!(:preference1) { create :preference, account_id: account1.id }
        schema "$ref" => "#/components/schemas/preference"
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
