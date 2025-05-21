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

  path "/catalogue/catalogues_variants_sizes" do
    post "Create a Catalogues variants size" do
        # tags "bx_block_catalogue", "catalogues_variants_sizes", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string,example: "Catalogues variants size-1"}
        }
      }

      let(:new_catealogue_variant_size) { "Catalogues variants size-1" }

      let(:params) {
        {
          name: new_catealogue_variant_size
        }
      }

      response "201", :success do
        schema "$ref" => "#/components/schemas/catalogues_variants_size"
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

    get "Get all catalogue variant size" do
    	 # tags "bx_block_catalogue", "catalogues_variants_sizes", "index"
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"

      let!(:catalogue_variant_size1) { create :catalogue_variant_size }
      let!(:catalogue_variant_size2) { create :catalogue_variant_size }

      response "200", :success do
      	schema "$ref" => "#/components/schemas/catalogues_variants_sizes_list"
      	run_test!
      end
    end
  end
end
