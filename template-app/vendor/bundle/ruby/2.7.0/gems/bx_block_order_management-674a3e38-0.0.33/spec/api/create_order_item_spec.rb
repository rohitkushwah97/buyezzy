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
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login")}
  let!(:order) { create :order, account_id: account.id }
  let(:catalogue) { create :catalogue }
  let(:catalogue_variant){create :catalogue_variant}
  
  path "/order_management/orders/{id}/add_order_items" do
    post "Add order items" do
      tags "add_order_items"
      # tags "bx_block_order_management", "orders", "add_order_items"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer,required:true, example: 1
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          order_items: {
            type: :array,
            items: {
              type: :object,
              properties: {
                catalogue_id: {type: :integer,example:1},
                quantity: {type: :integer,example:1},
                catalogue_variant_id: {type: :integer,example:1}
              }
            }
          }
        }
      }
      let(:quantity) { 1 }
      let(:id) {order.id}
      let(:params) do
        {
          order_items: [
            {
              catalogue_id: catalogue.id,
              catalogue_variant_id: catalogue_variant.id,
              quantity: 1
            }
          ]
        }
      end

      response "200", :success do
        schema "$ref" => "#/components/schemas/order"
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

      response "422", :unauthorized do
        let(:params) do
          {
            order_items: [
              {
                catalogue_id: catalogue.id,
                quantity: 0,
                catalogue_variant_id: catalogue_variant.id
              }
            ]
          }
        end
        schema type: :object,properties:{
          message: {
            type: :array,example: "quantity must be greater than 0"
          }
        }
        run_test!
      end

      response "422", :unauthorized do
        let(:params) do
          {
            order_items: [
              {
                catalogue_id: catalogue.id,
                quantity: quantity
              }
            ]
          }
        end
        schema type: :object,properties: {
          message: {
            type: :array,
            items:{type: :string,example: "catalogue_variant_id must be define"}
            
          }
        }
        run_test!
      end

      response "422", :unauthorized do
        let(:params) do
          {
            order_items: [
              {
                catalogue_variant_id: catalogue_variant.id,
                quantity: quantity
              }
            ]
          }
        end

        schema type: :object,properties: {
          message: {
            type: :array,
            items:{type: :string,example: "catalogue_id must be define"}
          }
        }
        run_test!
      end

      response "422", :unauthorized do
        let(:params) do
          {
            order_items: [
              {
                catalogue_variant_id: catalogue_variant.id,
                catalogue_id: catalogue.id,
                quantity: 100
              }
            ]
          }
        end
        schema type: :object,properties: {
          message: {
            type: :array,
            items:{type: :string,example: "Sorry, Product is out of stock for catalogue variant id"}
            
          }
        }
        run_test!
      end
    end
  end
end
