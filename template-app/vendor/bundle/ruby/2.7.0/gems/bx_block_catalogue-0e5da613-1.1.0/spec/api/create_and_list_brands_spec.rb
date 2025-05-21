require "swagger_helper"

RSpec.describe "/bx_block_catalogue", :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:attributes) { data["attributes"] }
  let(:json_response) { JSON.parse(attributes["settings"]) }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }

  let(:account) { create :email_account }

  path "/catalogue/brands" do
    post "Create a brand" do
      # tags "bx_block_catalogue", "brands", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string,example: "Brand-1"},
          currency: {type: :string,example:"usd"}
        }
      }

      let(:new_brand_name) { "test_brand 1" }
      let(:currency) { "USD" }

      let(:params) {
        {
          name: new_brand_name,
          currency: currency
        }
      }

     
      response "201", :success do
        schema "$ref" => "#/components/schemas/brand"
        run_test!
      end

      response "200", "Please Enter Valid Currency From List" do
        let(:currency) { "abc" }
        schema type: :object, properties: {
          message: {type: :string,example: "Please Enter Valid Currency From List,Currencies:[GBP,INR,USD,EUR]"}
        }
        run_test!
      end
      response "422", "name can't be blank" do
        let(:params) {
          {
            currency: currency
          }
        }
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: {
              id: {
                type: :string,nullable: true,example: "null"
              },
              type: {
                type: :string,example: "error"
              },
              attributes: {
                type: :object,
                properties: {
                  errors: {
                    type: :object,
                    properties: {
                      name: {
                        type: :array,
                        items: {type: :string,example: "can't be blank,has already been taken"}
                      }
                    },
                    required: [
                      :name
                    ]
                  }
                },
                required: [
                  :errors
                ]
              }
            },
            required: [
              :id,
              :type,
              :attributes
            ]
          }
        }
        run_test!
      end
    end
 
    get "Get all brands" do
       # tags "bx_block_catalogue", "brands", "index"
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"

      let!(:brand1) { create :brand}
      let!(:brand2) { create :brand}

      response "200",  "List of brands" do
        schema "$ref" => "#/components/schemas/brand_list"
        run_test!
      end
    end
  end
end
