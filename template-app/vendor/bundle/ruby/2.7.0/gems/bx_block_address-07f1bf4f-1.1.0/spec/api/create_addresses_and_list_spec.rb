require "swagger_helper"

RSpec.describe "/bx_block_address", :jwt do
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }

  let(:account) { create :email_account }
  let(:id) { account.id }

  let(:params) {
    {
      address: {
        latitude: 22.9734229,
        longitude: 78.6568942,
        address: "Random location for the test",
        address_type: "Home"
      }
    }
  }
  path "/address/addresses" do
    post "Create Address " do
      tags "bx_block_address", "addresses", "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          address: {
            type: :object,
            properties: {
              latitude: {type: :number,example: 22.9734229},
              longitude: {type: :number,example: 78.6568942},
              address: {type: :string,example: "Random location for the test"},
              address_type: {type: :string,example:"Home"}
            },
            required: ["address_type"]
          }
        }
      }
      response "201", :success do
        schema "$ref" => "#/components/schemas/address"
        run_test!
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end
      
      response "422",:unprocessable_entity do
        context "can't be blank" do
          let(:params) {
            {
              address: {
                address: "Random location for the test",
                address_type: ""
              }
            }
          }
          schema type: :object,properties: {
            errors: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  address_type: {
                    type: :string,example: "can't be blank"
                  }
                },
              }
            }
          }
          run_test!
        end
        context "Address type is not valid." do
          let(:params) {
            {
              address: {
                address: "Random location for the test",
                address_type: "abc"
              }
            }
          }
          schema type: :object,properties: {
            message: {
              type: :string,example: "Address type is not valid."
            }
          }
          run_test!
        end
      end
    end

    get "List of Address " do
      tags "bx_block_address", "addresses", "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"

      response "200", :success do
        schema "$ref" => "#/components/schemas/address_list"
        run_test!
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end
    end
  end
end
