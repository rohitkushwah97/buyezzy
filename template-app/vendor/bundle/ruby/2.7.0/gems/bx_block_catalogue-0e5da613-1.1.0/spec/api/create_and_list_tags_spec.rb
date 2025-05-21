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
  let(:catalogue) { create :catalogue }

  path "/catalogue/tags" do
    post "Create a tags" do
      # tags "bx_block_catalogue", "tags", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :integer,example:"tag-11"}
        }
      }

      let(:tag_name) { "tag-1" }
      let(:params) {
        {
          name: tag_name
        }
      }

      response "201", :success do
        schema "$ref" => "#/components/schemas/tag"
        run_test!
      end
      response "422", "name has already been taken" do
        let(:params) {
          {
            
            currency: tag_name
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

    get "Get all Tags" do
      # tags "bx_block_catalogue", "tags", "index"
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header,required: true, type: :string, example: "{{bx_blocks_api_token}}"

      let!(:tag1) { create :tag }
      let!(:tag2) { create :tag }

      response "200", :success do
        schema "$ref" => "#/components/schemas/tag_list"
        run_test!
      end
    end
  end
end
