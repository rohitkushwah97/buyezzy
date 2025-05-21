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
  let(:category) { create :category }
  let(:sub_category) { create :sub_category }
  let(:brand) { create :brand }
  
 

  path "/catalogue/catalogues/{id}" do
    get "Get a catalogue" do
    	# tags "bx_block_catalogue", "catalogues", "show"
      tags "show"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true,example:1

      let!(:catalogue1) { create :catalogue }
      let(:id) { catalogue1.id }

      response "200", :success do
      	schema "$ref" => "#/components/schemas/catalogues"
        run_test!
      end 

      response "404", "Catalogue with id  doesn't exists"do 
      	let(:id) { catalogue1.id+11}
      	schema type: :object, properties: {
          success: {type: :string,example: "Catalogue with id  doesn't exists"}
        }
        run_test!
      end 
    end

    put "Update a catalogue" do
      # tags "bx_block_catalogue", "catalogues", "update"
      tags "update"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true,example:1
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          category_id: {type: :integer,example:1},
          sub_category_id: {type: :integer,example:2},
          brand_id: {type: :integer,example:1},
          name: {type: :string,example:"Catalogue-22"},
          sku: {type: :string,example:"sku-1"},
          description: {type: :string,example:"First catalogue"},
          manufacture_date: {type: :string,example:"2020-10-19T14:59:08.817Z"},
          length: {type: :number,example:10.5},
          breadth: {type: :number,example: 1.5},
          height: {type: :integer,example: 2},
          stock_qty: {type: :integer,example:10},
          availability: {type: :string,example:"in_stock"},
          weight: {type: :number,example:2.2},
          price: {type: :number,example:1.0},
          recommended: {type: :boolean,example:true},
          on_sale: {type: :boolean,example:true},
          sale_price: {type: :number,example:0.05},
          discount: {type: :number,example:0.2},
			    images: {
			      type: :array,
			      items: {
		          type: :object,
		          properties: {
		            data: {
		              type: :string,example:"data:image/octet-stream;base64,UklGRiZXAABXRUJQVlA4IBpXAACQKAGdASpoAWgBPi0WiUMhoSEhpdjpGDAFiWJuBvKfysK5A2+gCSEmYDk9tPyP9rixv2v+2/p7+3/tr9636H/afbN8l9Df8j0COV/8l/bf3l/xH/////3o/wv+4/vHuZ/Pn+q9wD9N/8l/aP8P/7f8F8Z/qu/uX+59QP9F/uH+8/v/7zfMN/hP9j/mPcb/ZP8T/zP8Z/mfkA/pH9y+9/5yv+f7BX+O/23sC/0T/C/8r8//l4/13/k/0H+w///0T/1L/Pf+L/L/7b/8fQb/Qf7v/2Pz9+QD/w+oB/3PUA/8Xb6+eHpj+Tvn3+Ofdf5z8oP7l/6/9x903l35xe0P+f/fv2l91P5z+KPuv97/an+7/uX7ZXj36wvy3+AX8W/l3+B/sP7Yf4T92Pqd7keLvcf/u+oR7E/X/87/i/3Y/03y1fIf8H0n/tv77/oPzW+gH+e/0H/G/lL/d///93/6nwdvxn/E/2/uBfyT+r/6P/Gf6P/j/4j///bf/gf83/Wf6X/1/5j3H/ov+V/5P+U/0n/y/1f2C/yj+k/6L+6f5P/vf5n////z7y/ar+2fskfrp/sPz/"
		            },
		            filename: {
		              type: :string,example:"0E9240F1-46F8-4265-8CD8-A95E79BCC131.jpg",
		            },
		            content_type: {
		              type: :string,example: "image/jpeg"
		            }
		          },
		        }
			    }
        }
      }

      let(:category_id) { category.id }
      let(:params) {
        {
          category_id: category_id,
          sub_category_id: sub_category.id,
          brand_id: brand.id,
          name: "Catalogue-2",
          sku: "sku-3",
          description: "First catalogue",
          manufacture_date: DateTime.now,
          length: 10.5,
          breadth: 1.5,
          height: 2,
          stock_qty: 10,
          availability: "in_stock",
          weight: 2.2,
          price: 0.1,
          recommended: true,
          on_sale: false,
          sale_price: 0.05,
          discount: 0.2
        }
      }
      	let(:catalogue1) { create :catalogue }

     		let(:id) { catalogue1.id }
     	response "200", :success do
        schema "$ref" => "#/components/schemas/catalogues"
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

      response "404", "Catalogue with id  doesn't exists"do 
      	let(:id) { catalogue1.id+11}
      	schema type: :object, properties: {
          success: {type: :string,example: "Catalogue with id  doesn't exists"}
        }
        run_test!
      end 

    end

    delete "delete a catalogue" do
      # tags "bx_block_catalogue", "catalogues", "destroy"
      tags "destroy"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true, example:1

      let!(:catalogue1) { create :catalogue }

      let(:id) { catalogue1.id }
      response "200", :success do
        schema type: :object, properties: {
          success: {type: :boolean,example:true}
        }
        run_test!
      end

      response "404", :not_found do 
      	let(:id) { catalogue1.id+11}
      	schema type: :object, properties: {
          success: {type: :string,example: "Catalogue with id  doesn't exists"}
        }
        run_test!
      end 
    end
  end
end
