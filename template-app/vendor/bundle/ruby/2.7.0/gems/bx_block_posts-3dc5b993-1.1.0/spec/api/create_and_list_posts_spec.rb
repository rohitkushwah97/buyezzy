require "swagger_helper"

RSpec.describe "/bx_block_posts", :jwt do
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
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",activated: true}
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let(:category) { create :category }
  let(:sub_category) { create :sub_category }
  let(:encode_image) { Base64.encode64(File.binread(BxBlockPosts::Engine.root.join("./spec/support/unit/demo.jpeg"))) }
  let(:new_image) { "data:image/jpeg;base64, #{encode_image}" }

  let(:encode_video) { Base64.encode64(File.binread(BxBlockPosts::Engine.root.join("./spec/support/unit/video.mp4"))) }
  let(:new_video) { "data:video/mp4;base64, #{encode_video}" }

  path "/posts/posts" do
    post "Create a post" do
       # tags "bx_block_posts", "post", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
	        name: {type: :string,example:"postname"},
		      description: {type: :string,example:" test description"},
		      body: {type: :string,example:" test body"},
		      location: {type: :string,example:"location"},
		      category_id: {type: :integer,example:1},
		      sub_category_id: {type: :integer,example:1},
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
			    },
			    media: {
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

      let(:params) {
        {
        	name: "bx user",
		      description: "test description",
		      body: "test body",
		      location: "test location",
          category_id: category.id,
          sub_category_id: sub_category.id,
          images: [
		        {
		          "data": new_image,
		          "filename": "demo.jpeg",
		          "content_type": "image/jpeg"
		       	},
		       	{
		          "data": new_video,
		          "filename": "video.mp4",
		          "content_type": "video/mp4"
		       	}

			    ],
			    media: [
		        {
		          "data": new_image,
		          "filename": "demo.jpeg",
		          "content_type": "image/jpeg"
		       	 }
			    ]
        }
      }

      response "200", :success do
        schema "$ref" => "#/components/schemas/post"
        run_test!
      end

      response "422", :unprocessable_entity do
      	let(:params) {
	        {
	        	name: "bx user",
			      description: "test description",
			      body: "test body",
			      location: "test location",
	          category_id: category.id,
	          sub_category_id: sub_category.id,
	          images: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image"
			       	},
			       	{
			          "data": new_video,
			          "filename": "video.mp4",
			          "content_type": "video/mp4"
			       	}

				    ],
				    media: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	 }
				    ]
	        }
      	}
        schema type: :object,properties:{
          errors: {
            type: :array,example: 'The image is unsupported type, supported formates are["image/jpeg", "image/jpg", "image/png"]'
          }
        }
        run_test!
      end

      response "422", :unprocessable_entity do
      	let(:params) {
	        {
	        	name: "bx user",
			      description: "test description",
			      body: "test body",
			      location: "test location",
	          category_id: category.id,
	          sub_category_id: sub_category.id,
	          images: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	},
			       	{
			          "data": new_video,
			          "filename": "video.mp4",
			          "content_type": "video"
			       	}

				    ],
				    media: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	 }
				    ]
	        }
	      }
        schema type: :object,properties:{
          errors: {
            type: :array,example: 'The video is unsupported type, supported formates are ["video/mp4", "video/mov", "video/wmv", "video/flv", "video/avi", "video/mkv", "video/webm"]'
          }
        }
        run_test!
      end

      response "404", :not_found do
      	let(:params) {
	        {
	        	name: "bx user",
			      description: "test description",
			      body: "test body",
			      location: "test location",
	          category_id: category.id,
	          sub_category_id: sub_category.id+500,
	          images: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	}
				    ],
				    media: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	 }
				    ]
	        }
      	}
      	schema type: :object,properties:{
          errors: {
            type: :string,example: "Sub_category ID does not exist"
          }
        }
        run_test!
      end

      response "422", :unprocessable_entity do
      	let(:params) {
	        {
	        	name: "bx user",
			      description: "test description",
			      location: "test location",
	          category_id: category.id,
	          sub_category_id: sub_category.id,
	          images: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	},
			       	{
			          "data": new_video,
			          "filename": "video.mp4",
			          "content_type": "video/mp4"
			       	}

				    ],
				    media: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	 }
				    ]
	        }
      	}
        schema type: :object,properties:{
           data: {
			      type: :object,
			      properties: {
			        id: {type: :integer,nullable: true},
			        type: {type: :string,nullable: true,example: "error"},
			        attributes: {
			          type: :object,
			          properties: {
			            errors: {
			              type: :object,
			              properties: {
			                body: {
			                  type: :array,
			                  items: {
			                    type: :string,example: "can't be blank"
			                  }
			                }
			              }
			            }
			          }
			        }
			      }
			    }
        }
        run_test!
      end

      response "404", :not_found do
      	let(:params) {
	        {
	        	name: "bx user",
			      description: "test description",
			      body: "test body",
			      location: "test location",
	          category_id: category.id+500,
	          sub_category_id: sub_category.id,
	          images: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	}
				    ],
				    media: [
			        {
			          "data": new_image,
			          "filename": "demo.jpeg",
			          "content_type": "image/jpeg"
			       	 }
				    ]
	        }
      	}
      	schema type: :object,properties:{
          errors: {
            type: :string,example: "Category ID does not exist"
          }
        }
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
		          },
			      }
			    }
        }
        run_test!
      end

    end

    get "Get all posts " do
        # tags "bx_block_posts", "post", "create"
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"

      response "200", :success do
        schema "$ref" => "#/components/schemas/post_lists"
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
		          },
			      }
			    }
        }
        run_test!
      end
    end
  end
end
