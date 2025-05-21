# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/profile_bio", :jwt do
  let(:account1) { create :email_account, first_name: "first1", last_name: "last1", activated: true }
  let(:account2) { create :email_account, first_name: "first2", last_name: "last2" }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/profile_bio/view_profiles" do
    post "create a view profile" do
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
                  "account_id": {type: :integer, example: 1 },
                  "profile_bio_id": {type: :integer, example: 2 },
                  "view_by_id": {type: :integer, example: 1 },
                  "mutual_friends_count": {type: :integer, example: 0 }
                }
              }
            }
          }
        }
      }

      response "200", "create view profile successfully" do
        let!(:profile_bio1) { create :profile_bio, account_id: account1.id, personality: %w[Extrovert Introvert], interests: %w[Pets Mountains] }
        let(:params) do
          {
            data:{
              attributes: {
                "account_id": account1.id,
                "profile_bio_id": profile_bio1.id,
                "view_by_id": account2.id,
                "profile_image": {},
                "mutual_friends_count": 0
              }
            }
          }
        end
        schema "$ref" => "#/components/schemas/view_profile"
        run_test!
      end

      response "422", "profile Bio must exist" do
        let!(:profile_bio2) { create :profile_bio, account_id: account1.id, personality: %w[Extrovert Introvert], interests: %w[Pets Mountains] }
        let(:params) do
          {
            data:{
              attributes: {
                "account_id": account1.id,
                "profile_bio_id": profile_bio2.id + 10,
                "view_by_id": account2.id,
                "profile_image": {},
                "mutual_friends_count": 0
              }
            }
          }
        end
        schema type: :object,
          properties: {
            errors: {
              type: :array,
              items: {
                type: :object,
              },
              example: [
                "view_profile": {
                  "profile_bio": [
                    "must exist"
                  ]
                }
              ]
            }
          }
        run_test!
      end
    end

    get "Get a view profile" do
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :filter_by, in: :query, type: :string, example: "newest_first", required: false
      parameter name: :search_by_name, in: :query, type: :string, example: "first", required: false

      let!(:profile_bio3) { create :profile_bio, account_id: account1.id, personality: %w[Extrovert Introvert], interests: %w[Pets Mountains] }
      response "200", "get a view profile" do
        let!(:view_profile1) { create :view_profile, profile_bio_id: profile_bio3.id, view_by_id: account1.id }
        context "get a view profile" do
          schema "$ref" => "#/components/schemas/view_profile"
          run_test!
        end

        context "get a view profile with filter oldest_first" do
          let(:filter_by) { "newest_first" }
          schema "$ref" => "#/components/schemas/view_profile"
          run_test!
        end

        context "get a view profile with filter oldest_first" do
          let(:filter_by) { "oldest_first" }
          schema "$ref" => "#/components/schemas/view_profile"
          run_test!
        end

        context "get a view profile with search_by_name" do
          let(:search_by_name) { "first" }
          schema "$ref" => "#/components/schemas/view_profile"
          run_test!
        end
      end

      response "404", "view profiles does not found" do
        schema type: :object,
          properties: {
            message: {type: :string, example: "view profiles does not found"}
          }
        run_test!
      end
    end
  end
end
