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
  let(:account1) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540001",country_code:"+1",phone_number:"13108540001",device_id: "gfhfg",user_name: "user name",platform: "plateform",user_type: "user type",app_language_id: "1",last_visit_at: "2023-01-30T06:32:31.563Z",suspend_until: "2023-01-30T06:32:31.563Z"}
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",device_id: "gfhfg",user_name: "user name",platform: "plateform",user_type: "user type",app_language_id: "1",last_visit_at: "2023-01-30T06:32:31.563Z",suspend_until: "2023-01-30T06:32:31.563Z"}
  let(:id) { account.id }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let!(:order) { create :order, account_id: account.id }
  let!(:category) {create :category}
  let!(:sub_category) {create :sub_category}

  path "/order_management/orders/" do
    post "Create order " do
      tags "create"
      # tags "bx_block_order_management", "orders", "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          catalogue_id: {type: :integer, example: 1},
          catalogue_variant_id: {type: :integer, example: 1},
          amount: {type: :integer, example: 10},
          quantity: {type: :integer, example: 2},
          name: {type: :string, example: "test"},
          flat_no: {type: :string, example: "B123"},
          order: {type: :string, example: "test"},
          order_type: {type: :string, example: "test"},
          order_line_2: {type: :string, example: "test"},
          zip_code: {type: :string, example: "test"},
          phone_number: {type: :string, example: "test"},
          order_for: {type: :string, example: "test1"},
          city: {type: :string, example: "test"},
          state: {type: :string, example: "test"},
          landmark: {type: :string, example: "test"},
          residential: {type: :boolean, example: true},
          is_default: {type: :boolean, example: false}
        }
      }

      let(:catalogue) { create :catalogue, category: category, sub_category: sub_category }
      let(:catalogue_variant) { create :catalogue_variant, catalogue: catalogue }
      let(:coupon_code) { create :coupon_code }
      let(:coupon_code1) { create :coupon_code, min_cart_value: "200" }
      let(:catalogue_id) { catalogue.id }
      let(:catalogue_variant_id) { catalogue_variant.id }
      let(:delivery_address) { create :delivery_address}
      
      let(:custom_label) { "Custom" }
      let(:quantity) { 1 }
      let(:params) do
        {
          catalogue_id: catalogue_id,
          catalogue_variant_id: catalogue_variant_id,
          quantity: quantity,
          coupon_code_id: coupon_code.id,
          custom_label: custom_label,
          amount: 1000,
          delivery_address_id: delivery_address.id
        }
      end

      response "200", :success do
        schema "$ref" => "#/components/schemas/order_management_orders"
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
        let(:quantity) { 0 }
        schema type: :object,properties:{
			    msg: {
                type: :string,example: "quantity must be greater than 0"
              }
        }
        run_test!
      end

      response "404", :"order with cart id" do
        let(:params) do
          {
            catalogue_id: catalogue_id,
            catalogue_variant_id: catalogue_variant_id,
            quantity: quantity,
            coupon_code_id: coupon_code1.id,
            custom_label: custom_label,
            cart_id: "12345678"
          }
        end

        run_test!

        it "Order not found" do
          expect(json["errors"]).to eq "Sorry, cart is not found"
        end
      end

      response "422", :unauthorized do
        let(:params) do
          {
            catalogue_id: catalogue_id,
            quantity: quantity,
            coupon_code_id: coupon_code.id,
            custom_label: custom_label
          }
        end

        before do |example|
          BxBlockOrderManagement::Order.destroy_all
          submit_request(example.metadata)
          assert_response_matches_metadata(example.metadata)
        end

        it "catalogue varint missing" do
          expect(json["msg"]).to eq "catalogue_variant_id must be define"
        end
      end

      response "404", :not_found do
        let(:catalogue_variant_id) { 0 }

        before do |example|
          BxBlockOrderManagement::Order.destroy_all
          submit_request(example.metadata)
          assert_response_matches_metadata(example.metadata)
        end

        it "Product Variant is invalid" do
          expect(errors).to eq "Sorry, Product Variant is not found for this product"
        end

        it "should not create order" do
          expect(BxBlockOrderManagement::Order.count).to eq 0
        end
      end

      response "404", "Sorry, Product is out of stock" do
        let(:quantity) { catalogue_variant.stock_qty + 1 }

        before do |example|
          BxBlockOrderManagement::Order.destroy_all
          submit_request(example.metadata)
          assert_response_matches_metadata(example.metadata)
        end

        it "Product Variant is invalid" do
          expect(errors).to eq "Sorry, Product is out of stock"
        end

        it "should not create order" do
          expect(BxBlockOrderManagement::Order.count).to eq 0
        end
      end
    end

    get "List of orderes" do
      tags "index"
      # tags "bx_block_order_management", "orders", "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      response "200", :success do
        let!(:order1) { create :order }
        let!(:order2) { create :order }
          schema "$ref" => "#/components/schemas/list_of_orders"
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
        let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }
        schema type: :object,properties:{
          message: {type: :string,example: "No order record found."}
        }
        run_test!
      end
    end
  end
end