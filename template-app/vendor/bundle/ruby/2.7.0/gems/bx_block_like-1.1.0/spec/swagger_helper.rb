# frozen_string_literal: true

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
        title: "bx_block_like",
        version: "1.0.0",
        description: "Like block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          like_create:{
            type: :object,
            properties:{
              data:{
                  type: :object,
                  properties:{
                    id: {type: :string,example: "1"},
                    type: {type: :string,example:"like"},
                    attributes:{
                      type: :object,
                      properties:{
                        likeable_id: {type: :integer,example:699},
                        likeable_type: {type: :string,example:"BxBlockPosts::Post"},
                        like_by_id: {type: :integer,example:410},
                        created_at: {type: :string,format: :datetime,example:"2023-03-22T07:54:09.187Z"},
                        updated_at: {type: :string,format: :datetime,example:"2023-03-22T07:54:09.187Z"}
                      }
                    }
                  }
                
              }
            }
          },
          like:{
            type: :object,
            properties:{
              data:{
                type: :array,
                items:{
                  type: :object,
                  properties:{
                    id: {type: :string,example: "1"},
                    type: {type: :string,example:"like"},
                    attributes:{
                      type: :object,
                      properties:{
                        likeable_id: {type: :integer,example:699},
                        likeable_type: {type: :string,example:"BxBlockPosts::Post"},
                        like_by_id: {type: :integer,example:410},
                        created_at: {type: :string,format: :datetime,example:"2023-03-22T07:54:09.187Z"},
                        updated_at: {type: :string,format: :datetime,example:"2023-03-22T07:54:09.187Z"}
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
