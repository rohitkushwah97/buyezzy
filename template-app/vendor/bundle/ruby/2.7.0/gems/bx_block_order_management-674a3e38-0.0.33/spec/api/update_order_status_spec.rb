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
  let!(:order1) { create :order, account_id: account.id,status:"in_cart"}


  path "/order_management/orders/{id}/update_order_status"  do
    put "Update order status" do
      tags "Update order status"
      # tags "bx_block_order_management", "orders", "update_order_status"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer,required:true, example: 1
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          status: {type: :string, example: "in_cart"}
        }
      }
      let(:params) do
        {
          status: "in_cart"
        }
      end
      let(:id) { order.id }
      response "200", :success do
        schema "$ref" => "#/components/schemas/order"
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

      response "422", :unprocessable_entity do
        let!(:id) {order1.id}
        schema type: :object,properties: {
          message: { type: :string,example: "Your order is in cart."}
        }
        run_test!
      end
    end
  end
end
