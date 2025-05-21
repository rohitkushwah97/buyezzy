# frozen_:string_literal: true

require "rails_helper"

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join("swagger").to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'

  config.swagger_docs = {
    "v1/swagger.json" => {
      openapi: "3.0.1",
      info: {
        title: "bx_block_posts",
        version: "1.0.0",
        description: "Post block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          post:{
					  type: :object,
					  properties: {
					    data: {
					      type: :object,
					      properties: {
					        id: { type: :string,nullable: false, example: 1},
					        type: { type: :string,nullable: false,example: "post" },
					        attributes: {
					          type: :object,
					          properties: {
					            id: { type: :integer,example: 1},
					            name: {type: :string,example: "name" },
					            description: {type: :string,example: "description"},
					            body: {type: :string,nullable: false,example: "body"},
					            location: {type: :string,example: "location"},
					            account_id: {type: :integer,example: 1},
					            category_id: {type: :integer,example: 2},
					            sub_category_id: {type: :integer,example: 2},
					            created_at: {type: :string,example: "less than a minute ago" },
					            updated_at: { type: :string,example: "2023-03-22T11:19:11.750Z"},
					            model_name: {type: :string,example:"BxBlockPosts::Post"},
					            images_and_videos: {
					              type: :array,
					              items: {
					                type: :object,
					                properties: {
					                  id: {type: :integer,example:1},
					                  url: {type: :string,example: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBYnc9IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--cd7c595dfc48c01aeca33d141d013eea4a31a85d/w3hswrgiu6udun2m7ui4.jpeg?type=image"}
					                }
					              }
					            },
					            media: {
					              type: :array,
					              items: {
					                type: :object,
					                properties: {
					                  id: {type: :integer,example:1},
					                  url: {type: :string,example: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBYjQ9IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--7ca075b7b62023230781fa33e226340ba14228bd/joban-khangura-VdL_VPHug-k-unsplash.jpg"},
					                  filename: {type: :string,example: "joban-khangura-VdL_VPHug-k-unsplash.jpg"},
					                  content_type: {type: :string,example: "image/jpg"}
					                }
					              }
					            }
					          }
					        }
					      }
					    }
					  }
					},
					post_lists:{
					  type: :object,
					  properties: {
					    data: {
					      type: :array,
					      items: {
					        type: :object,
					        properties: {
					          id: {type: :string, nullable: false, example: "1"},
					          type: {type: :string, nullable: false, example: "post"},
					          attributes: {
					            type: :object,
					            properties: {
						            id: { type: :integer,example: 1},
						            name: {type: :string,example: "name" },
						            description: {type: :string,example: "description"},
						            body: {type: :string,example: "body"},
						            location: {type: :string,example: "location"},
						            account_id: {type: :integer,example: 1},
						            category_id: {type: :integer,example: 2},
						            sub_category_id: {type: :integer,example: 2},
						            created_at: {type: :string,example: "less than a minute ago" },
						            updated_at: { type: :string,example: "2023-03-22T11:19:11.750Z"},
						            model_name: {type: :string,example:"BxBlockPosts::Post"},
						            images_and_videos: {
						              type: :array,
						              items: {
						                type: :object,
						                properties: {
						                  id: {type: :integer,example:1},
						                  url: {type: :string,example: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBYnc9IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--cd7c595dfc48c01aeca33d141d013eea4a31a85d/w3hswrgiu6udun2m7ui4.jpeg?type=image"}
						                }
						              }
						            },
						            media: {
						              type: :array,
						              items: {
						                type: :object,
						                properties: {
						                  id: {type: :integer,example:1},
						                  url: {type: :string,example: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBYjQ9IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--7ca075b7b62023230781fa33e226340ba14228bd/joban-khangura-VdL_VPHug-k-unsplash.jpg"},
						                  filename: {type: :string,example: "joban-khangura-VdL_VPHug-k-unsplash.jpg"},
						                  content_type: {type: :string,example: "image/jpg"}
						                }
						              }
						            }
						          }
					          }
					        }
					      }
					    }
					  }
					}
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  # config.swagger_format = :yaml
  config.swagger_format = :json
end
