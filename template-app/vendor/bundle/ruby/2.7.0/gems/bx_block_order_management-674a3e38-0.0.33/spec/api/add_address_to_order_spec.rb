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
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",device_id: "gfhfg",user_name: "user name",platform: "plateform",user_type: "user type",app_language_id: "1",last_visit_at: "2023-01-30T06:32:31.563Z",suspend_until: "2023-01-30T06:32:31.563Z"}
  let(:id) { account.id }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let!(:order) { create :order, account_id: account.id }

  path "/order_management/orders/{id}/add_address_to_order" do
    put "Add Address to Order" do
      tags "add_address_to_order"
      # tags "bx_block_order_management", "orders", "add_address_to_order"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path,required: true, type: :integer, example: 1
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          address_id: {type: :integer,example:1},
          address: {
            type: :object,
            properties: {
              billing_address: {
                type: :object,
                properties: {
                  name: {type: :string, example: "test"},
                  address_type: {type: :string, example: "work"},
                  address: {type: :string, example: "line"},
                  address_line_2: {type: :string, example: "line2"}
                }
              }
            }
          }
        }
      }
      let!(:order) { create :order, account_id: account.id }
      let!(:address) { create :delivery_address, account_id: account.id }
      let(:id) { order.id }

      let(:billing_address_details) do
        {
          address_id: address.id,
          address:{
            billing_address: {
              name: "Address 1",
              flat_no:  "10",
              address_type: "home",
              address:"Street 1 building 2",
              address_line_2: "Some details",
              zip_code: 100,
              phone_number:"+380268294322"
            }
          }
        }
      end

      let(:params) { billing_address_details }

      response "200", :success do
        schema type: :object,properties: {
          message: {type: :string, example: "Address added successfully"}
        }

        before do |example|
          submit_request(example.metadata)
          assert_response_matches_metadata(example.metadata)
        end

        it "Should have status 200" do
          expect(response.status).to eq 200
        end

        it "Should have same status message" do
          json_response = JSON.parse(response.body)
          expect(json_response["message"]).to eq("Address added successfully")
        end
      end

      response "404", :"delivery address not defined" do
        let(:billing_address_details) do
          {
            address_id: address.id+1,
            address:{
              billing_address: {
                name: "Address 1",
                flat_no:  "10",
                address_type: "home",
                address:"Street 1 building 2",
                address_line_2: "Some details",
                zip_code: 100,
                phone_number:"+380268294322"
              }
            }
          }
        end
        schema type: :object,properties: {
          message: {type: :string, example: "Delivery ID does not exist"}
        }

        before do |example|
          BxBlockOrderManagement::DeliveryAddress.destroy_all
          submit_request(example.metadata)
          assert_response_matches_metadata(example.metadata)
        end

        it "delivery address not defined" do
          expect(json["message"]).to eq "Delivery ID does not exist"
        end
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
        let(:id) { order.id+1 }
        schema type: :object,properties: {
          message: {
            type: :string, example: "Order ID does not exist (or) Order Id does not belongs to current user"
          }
        }
        run_test!
      end
    end
  end
end
