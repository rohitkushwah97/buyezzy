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
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let!(:order) { create :order, account_id: account.id}
  path "/order_management/orders/{id}"  do
    delete "delete order" do
      tags "delete"
      # tags "bx_block_order_management", "orders", "delete"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer,required:true, example: 1
      
      let(:id) { order.id }
      response "200", :success do
        schema type: :object,properties: {
          message: {
            type: :string, example: "Order deleted successfully"
          }
        }
        run_test!
      end

      response "404", :not_found do
        let(:id) { order.id+22 }
        schema type: :object,properties: {
          message: {
            type: :string, example: "Order ID does not exist (or) Order Id does not belongs to current user"
          }
        }
        run_test!
      end

      response "400",:unauthorized do
        let!(:token) { "Invalid token" }
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

    get "get order"do
     tags "show"
      # tags "bx_block_order_management", "orders", "show"
      # consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer,required:true, example: 1
      
      let(:id) { order.id }
      response "200", :success do
        schema "$ref" => "#/components/schemas/order"
        run_test!
        before do |example|
          submit_request(example.metadata)
          assert_response_matches_metadata(example.metadata)
        end

        it "Should have status 200" do
          expect(response.status).to eq 200
        end

        it "Should have same response Account Id" do
          json_response = JSON.parse(response.body)
          expect(json_response["data"]["attributes"]["account_id"]).to eq account.id
        end
      end

      response "404", :not_found do
        let(:id) { order.id+22 }
        schema type: :object,properties: {
          message: {
            type: :string, example: "Order ID does not exist (or) Order Id does not belongs to current user"
          }
        }
        run_test!
      end

      response "400",:unauthorized do
        let!(:token) { "Invalid token" }
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
