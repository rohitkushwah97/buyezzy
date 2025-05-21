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
  let!(:order2) { create :order, account_id: account.id,status:"cancelled"}
  path "/order_management/orders/{id}/cancel_order"  do
    put "Cancel order" do
      tags "cancel_order"
      # tags "bx_block_order_management", "orders", "cancel_order"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer,required:true, example: 1
      
      let(:id) { order.id }
      response "200", :success do
        schema type: :object,properties: {
          message: {
            type: :string, example: "Order cancelled successfully"
          }
        }
        run_test!
      end

      response "404", :not_found do
        let(:id) { order.id+22 }
			  schema type: :object,properties:{
			    errors: {
			      type: :array,
	          items: {
			        type: :string,example: "Record not found"
	          }
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
          message: { type: :string,example: "Your order is in cart. so no need to cancel it"}
        }
        run_test!
      end

      response "200", :success do
        let!(:id) {order2.id}
        schema type: :object,properties: {
          message: { type: :string,example: "Order already cancelled"}
        }
        run_test!
      end
    end
  end
end
