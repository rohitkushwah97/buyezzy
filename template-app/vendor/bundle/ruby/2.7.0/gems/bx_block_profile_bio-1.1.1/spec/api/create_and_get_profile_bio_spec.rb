# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/profile_bio", :jwt do
  let(:account1) { create :email_account, first_name: "first1", last_name: "last1" }
  let(:account2) { create :email_account, first_name: "first2", last_name: "last2" }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/profile_bio/profile_bios" do
    post "Create a profile bio" do
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
                  height: { type: :string, example: "5.5" },
                  weight: { type: :string, example: "50" },
                  height_type: { type: :string,  example: "foot" },
                  weight_type: { type: :string, example: "kg" },
                  body_type: { type: :string, example: "Athletic" },
                  mother_tougue: { type: :string,  example: "English" },
                  religion: { type: :string,  example: "Jain" },
                  zodiac: { type: :string,  example: "Single" },
                  marital_status: { type: :string,  example: "5.5" },
                  languages: {
                    type: :array,
                    items: {
                      type: :string
                    },
                    example: ["test1", "test2", "test3"]
                  },
                  about_me: {type: :string, example: "Famous for wearing no socks in cold weather"},
                  personality: {
                    type: :array,
                    items: {
                      type: :string
                    },
                    example: ["Extrovert", "Introvert", "Angry"]
                  },
                  interests: {
                    type: :array,
                    items: {
                      type: :string
                    },
                    example: ["Sports", "Fitness"]
                  },
                  smoking: { type: :string,  example: "No" },
                  drinking: { type: :string,  example: "No" },
                  looking_for: { type: :integer,  example: 5 },
                  about_business: { type: :string,  example: "about_business" }
                }
              }
            }
          }
        }
      }

      response "201", "profile bio created successfully" do
        let(:params) do
          {
            data:{
              attributes: {
                "height":"5.5",
                "weight":"50",
                "height_type":"foot",
                "weight_type":"kg",
                "body_type":"Athletic",
                "mother_tougue":"Hindi",
                "religion":"Jain",
                "zodiac":"Taurus",
                "marital_status":"Married",
                "languages":["test1", "test2", "test3"],
                "about_me":"Famous for wearing no socks in cold weather",
                "personality":["Extrovert", "Introvert", "Angry"],
                "interests":["Sports", "Cooking", "Fitness"],
                "smoking":"No",
                "drinking":"No",
                "looking_for":"Ballroom dancing",
                "about_business":"Something"
              }
            }
          }
        end
        schema "$ref" => "#/components/schemas/profile_bio"
        run_test!
      end

      response "422", "Profile bio has been already created or pass invalid params" do
        context "Profile bio has been already created" do
          let!(:profile_bio1) { create :profile_bio, account_id: account1.id, personality: %w[Extrovert Introvert], interests: %w[Pets Mountains] }
          let!(:params) do
          {
            data:{
              attributes: {
                "height":"5.5",
                "weight":"50",
                "height_type":"foot",
                "weight_type":"kg",
                "body_type":"Athletic",
                "mother_tougue":"Hindi",
                "religion":"Jain",
                "zodiac":"Taurus",
                "marital_status":"Married",
                "languages":["test1", "test2", "test3"],
                "about_me":"Famous for wearing no socks in cold weather",
                "personality":["Extrovert", "Introvert", "Angry"],
                "interests":["Sports", "Cooking", "Fitness"],
                "smoking":"No",
                "drinking":"No",
                "looking_for":"Ballroom dancing",
                "about_business":"Something"
              }
            }
          }
         end
          run_test!
        end

        context "pass invalid params" do
          let(:params) do
            {
              data:{
                attributes: {
                  "height":"5.5",
                  "weight":"50",
                  "height_type":"foot",
                  "weight_type":"kg",
                  "body_type":"Athletic",
                  "mother_tougue":"Hindi",
                  "religion":"Jain",
                  "zodiac":"Taurus",
                  "marital_status":"Married",
                  "languages":["test1", "test2", "test3"],
                  "about_me":"Famous for wearing no socks in cold weather",
                  "personality":["Extrovert", "Introvert", "Angry"],
                  "interests":["Sports", "Cooking", "Fitness1"],
                  "smoking":"No",
                  "drinking":"No",
                  "looking_for":"Ballroom dancing",
                  "about_business":"Something"
                }
              }
            }
          end

          run_test!
        end
      end
    end

    get "Get a profile bio" do
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      response "200", "get a profile bio" do
        let!(:profile_bio1) { create :profile_bio, account_id: account1.id, personality: %w[Extrovert Introvert], interests: %w[Pets Mountains] }
        schema "$ref" => "#/components/schemas/profile_bio"
        run_test!
      end

      response "404", "Profile bio doesn't exists" do
        let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        schema type: :object,
          properties: {
            message: {type: :string, example: "Profile bio doesn't exists"}
          }
        run_test!
      end
    end
  end
end
