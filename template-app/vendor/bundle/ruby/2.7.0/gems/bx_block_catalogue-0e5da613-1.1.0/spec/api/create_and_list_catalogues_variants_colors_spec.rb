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

  path "/catalogue/catalogues_variants_colors" do
    post "Create a Catalogues variants color" do
       # tags "bx_block_catalogue", "catalogues_variants_colors", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string,example: "Catalogue variant color 1"}
        }
      }

      let(:new_catealogue_variant_color_name) { "Catalogues variants color-1" }

      let(:params) {
        {
          name: new_catealogue_variant_color_name
        }
      }

      response "201", :success do
        schema "$ref" => "#/components/schemas/catalogues_variants_color"
        run_test!
      end

      response "422", "name can't be blank" do
        let(:params) {
          {
            name: ""
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
                        items: {type: :string,example: "can't be blank"}
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

    get "Get all catalogue variant color" do
       # tags "bx_block_catalogue", "catalogues_variants_colors", "index"
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"

      let!(:catalogue_variant_color1) { create :catalogue_variant_color }
      let!(:catalogue_variant_color2) { create :catalogue_variant_color }

      response "200", :success do
      	schema "$ref" => "#/components/schemas/catalogues_variants_color_list"
      	run_test!
      end
    end
  end
end
