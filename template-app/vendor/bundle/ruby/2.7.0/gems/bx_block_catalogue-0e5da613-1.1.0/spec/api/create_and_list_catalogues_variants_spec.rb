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
  let(:catalogue_variant_color) { create :catalogue_variant_color }
  let(:catalogue_variant_size) { create :catalogue_variant_size }

  path "/catalogue/catalogues_variants" do
    post "Create a Catalogues variants" do
       # tags "bx_block_catalogue", "catalogues_variants", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          catalogue_id: {type: :integer,example: 1},
          catalogue_variant_color_id: {type: :integer,example: 1},
          catalogue_variant_size_id: {type: :integer,example: 1},
          price: {type: :string,example: "10.5"},
          stock_qty: {type: :integer,example: 3},
          on_sale: {type: :boolean,example: true},
          sale_price: {type: :string,example: "9.0"},
          discount_price: {type: :string,example: "1.0"},
          length: {type: :number,example: 3.3},
          breadth: {type: :number,example: 2.5},
          height: {type: :number,example: 100},
          images: {
            type: :object,
            properties: {
              data: {
                type: :string,example: "data:image/octet-stream;base64,UklGRiZXAABXRUJQVlA4IBpXAACQKAGdASpoAWgBPi0WiUMhoSEhpdjpGDAFiWJuBvKfysK5A2+gCSEmYDk9tPyP9rixv2v+2/p7+3/tr9636H/afbN8l9Df8j0COV/8l/bf3l/xH/////3o/wv+4/vHuZ/Pn+q9wD9N/8l/aP8P/7f8F8Z/qu/uX+59QP9F/uH+8/v/7zfMN/hP9j/mPcb/ZP8T/zP8Z/mfkA/pH9y+9/5yv+f7BX+O/23sC/0T/C/8r8//l4/13/k/0H+w///0T/1L/Pf+L/L/7b/8fQb/Qf7v/2Pz9+QD/w+oB/3PUA/8Xb6+eHpj+Tvn3+Ofdf5z8oP7l/6/9x903l35xe0P+f/fv2l91P5z+KPuv97/an+7/uX7ZXj36wvy3+AX8W/l3+B/sP7Yf4T92Pqd7keLvcf/u+oR7E/X/87/i/3Y/03y1fIf8H0n/tv77/oPzW+gH+e/0H/G/lL/d///93/6nwdvxn/E/2/uBfyT+r/6P/Gf6P/j/4j///bf/gf83/Wf6X/1/5j3H/ov+V/5P+U/0n/y/1f2C/yj+k/6L+6f5P/vf5n////z7y/ar+2fskfrp/sPz/"
              }
            },
          }
        }
      }

      let(:catalogue_id) { catalogue.id }
      let(:params) {
        {
          catalogue_id: catalogue_id,
          catalogue_variant_color_id: catalogue_variant_color.id,
          catalogue_variant_size_id: catalogue_variant_size.id,
          price: 10.5,
          stock_qty: 3,
          on_sale: true,
          sale_price: 9,
          discount_price: 1,
          length: 3.3,
          breadth: 2.5,
          height: 100,
          images: {
            type: :object,
            properties: {
              data: {
                type: :string,example: "data:image/octet-stream;base64,UklGRiZXAABXRUJQVlA4IBpXAACQKAGdASpoAWgBPi0WiUMhoSEhpdjpGDAFiWJuBvKfysK5A2+gCSEmYDk9tPyP9rixv2v+2/p7+3/tr9636H/afbN8l9Df8j0COV/8l/bf3l/xH/////3o/wv+4/vHuZ/Pn+q9wD9N/8l/aP8P/7f8F8Z/qu/uX+59QP9F/uH+8/v/7zfMN/hP9j/mPcb/ZP8T/zP8Z/mfkA/pH9y+9/5yv+f7BX+O/23sC/0T/C/8r8//l4/13/k/0H+w///0T/1L/Pf+L/L/7b/8fQb/Qf7v/2Pz9+QD/w+oB/3PUA/8Xb6+eHpj+Tvn3+Ofdf5z8oP7l/6/9x903l35xe0P+f/fv2l91P5z+KPuv97/an+7/uX7ZXj36wvy3+AX8W/l3+B/sP7Yf4T92Pqd7keLvcf/u+oR7E/X/87/i/3Y/03y1fIf8H0n/tv77/oPzW+gH+e/0H/G/lL/d///93/6nwdvxn/E/2/uBfyT+r/6P/Gf6P/j/4j///bf/gf83/Wf6X/1/5j3H/ov+V/5P+U/0n/y/1f2C/yj+k/6L+6f5P/vf5n////z7y/ar+2fskfrp/sPz/"
              }
            },
          }
        }
      }

      response "201", :success do
        schema "$ref" => "#/components/schemas/catalogues_variant"
        run_test!
      end


	    response "422", "catalogue_id can't be blank" do
        let(:catalogue_id) { catalogue.id + 1 }
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
                      catalogue: {
                        type: :array,
                        items: {type: :string,example: "must exist"}
                      }
                    },
                    required: [
                      :catalogue
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

    get "Get all catalogue variant" do
      # tags "bx_block_catalogue", "catalogues_variants", "index"
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"

      let!(:catalogue_variant1) { create :catalogue_variant }
      let!(:catalogue_variant2) { create :catalogue_variant }

      response "200", :success do
        schema "$ref" => "#/components/schemas/catalogues_variants_list"
        run_test!
      end
    end
  end
end
