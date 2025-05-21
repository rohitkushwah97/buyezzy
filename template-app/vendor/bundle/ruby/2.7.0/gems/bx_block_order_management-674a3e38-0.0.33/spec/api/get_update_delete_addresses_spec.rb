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

  path "/order_management/addresses/{id}" do
    get "Show addresses " do
      tags "show"
      # tags "bx_block_order_management", "addresses", "show"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true, example: 1
      let!(:address) { FactoryBot.create(:delivery_address, account_id: account.id) }
      let(:id) { address.id }

      response "200", :success do
        schema "$ref" => "#/components/schemas/addresses"
        run_test!
      end

      response "404", :not_found do 
      	let(:id) { address.id+1 }
        schema type: :object,properties:{
          message: {
            type: :string,example:"Address ID does not exist"
          }
        }
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
    put "Update addresses " do
      tags "update "
       # tags "bx_block_order_management", "addresses", "update"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true,example: 1
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
        	name: {type: :string,example:"namee"},
          flat_no: {type: :string,example:"abcde"},
          address: {type: :string,example: "place addresse"}
        }
      }
      let!(:address) { FactoryBot.create(:delivery_address, account_id: account.id) }
      let(:id) { address.id }

      let(:params) { address_params }

     	response "200", :success do
        schema "$ref" => "#/components/schemas/addresses"
        run_test!
      end

      response "404", :not_found do 
      	let(:id) { address.id+1 }
        schema type: :object,properties:{
          message: {
            type: :string,example:"Address ID does not exist"
          }
        }
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

    delete "Delete a Address" do
      tags "delete"
      # tags "bx_block_order_management", "addresses", "destroy"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true, example:1

      let(:address) { create(:delivery_address, account_id: account.id) }
      let(:id) { address.id }

      response "200", :success do
        schema type: :object,properties: {
          message: {type: :string,example:"Address deleted successfully"}
        }
        run_test!
      end

      response "404", :not_found do 
      	let(:id) { address.id+1 }
        schema type: :object,properties:{
          message: {
            type: :string,example:"Address ID does not exist"
          }
        }
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
  end
end
