# frozen_string_literal: true
require "swagger_helper"

RSpec.describe "bx_block_order_management", :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:account2) { create :email_account}
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",device_id: "gfhfg",user_name: "user name",platform: "plateform",user_type: "user type",app_language_id: "1",last_visit_at: "2023-01-30T06:32:31.563Z",suspend_until: "2023-01-30T06:32:31.563Z",
  status: 1,stripe_id: "test123",stripe_subscription_id: "test123",stripe_subscription_date: "2023-01-30T06:32:31.563Z"}
  let(:id) { account.id }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let!(:address) { FactoryBot.create(:delivery_address, account_id: account.id) }
  let(:address_params) do
    {
      name: address.name,
      flat_no: address.flat_no,
      zip_code: address.zip_code,
      phone_number: address.phone_number,
      latitude: address.latitude,
      longitude: address.longitude,
      residential: address.residential,
      city: address.city,
      state_code: address.state_code,
      country_code: address.country_code,
      state: address.state,
      country: "country",
      address_line_2: address.address_line_2,
      address_type: address.address_type,
      landmark: address.landmark,
      is_default: address.is_default,
      address_for: address.address_for,
      address: "Address details"
    }
  end

  path "/order_management/addresses/" do
    post "Create Address " do
      tags "create"
      # tags "bx_block_order_management", "addresses", "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string,example:"name"},
          flat_no: {type: :string,example:"abcd"},
          address: {type: :string,example:"aa"},
          address_type: {type: :string,example:"aa"},
          address_line_2: {type: :string,example:"aa"},
          zip_code: {type: :string,example:"aa"},
          phone_number: {type: :string,example:"9876543211"},
          address_for: {type: :string,example:"abcd"},
          city: {type: :string,example:"city"},
          country: {type: :string,example:"country"},
          state: {type: :string,example:"state"},
          landmark: {type: :string,example:"landmark"},
          residential: {type: :boolean,example:true},
          is_default: {type: :boolean,example:true}
        }
      }
      let(:params) { address_params }

      response "200", :success do
        schema "$ref" => "#/components/schemas/addresses"
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
              }
            }
          }
        }
        run_test!
      end
    end

    get "List of Addresses" do
      tags "index"
      # tags "bx_block_order_management", "addresses", "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"

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
              }
            }
          }
        }
        run_test!
      end
      response "404", :not_found do 
        let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        schema type: :object,properties:{
          message: {
            type: :string,example:"No addresses exist"
          }
        }
        run_test!
      end
    end
  end
end
