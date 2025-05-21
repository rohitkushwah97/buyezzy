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
        title: "bx_block_address",
        version: "1.0.0",
        description: "Address block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          address:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable: false, example: "1"},
                  type: {type: :string,nullable: false, example: "address"},
                  attributes: {
                    type: :object,
                    properties: {
                      latitude: { type: :number,nullable: true,example: 22.9734229},
                      longitude: {type: :number,nullable: true,example: 78.6568942},
                      address: {type: :string,nullable: false,example: "Random location for the test"},
                      address_type: { type: :string,nullable:false,example: "Home"}
                    }
                  }
                }
              },
              meta: {
                type: :object,
                properties: {
                  message: {type: :string,example: "Address Created Successfully"}
                }
              }
            }
          },
          address_update:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable: false, example: "1"},
                  type: {type: :string,nullable: false, example: "address"},
                  attributes: {
                    type: :object,
                    properties: {
                      latitude: { type: :number,nullable: true,example: 22.9734229},
                      longitude: {type: :number,nullable: true,example: 78.6568942},
                      address: {type: :string,nullable: false,example: "Random location for the test"},
                      address_type: { type: :string,nullable:false,example: "Home"}
                    }
                  }
                },
              },
              meta: {
                type: :object,
                properties: {
                  message: {type: :string,example: "Address Updated Successfully"}
                },
              }
            },
          },
          address_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items:{
                  type: :object,
                  properties: {
                    id: {type: :string,nullable: false, example: "1"},
                    type: {type: :string,nullable: false, example: "address"},
                    attributes: {
                      type: :object,
                      properties: {
                        latitude: { type: :number,nullable: true,example: 22.9734229},
                        longitude: {type: :number,nullable: true,example: 78.6568942},
                        address: {type: :string,nullable: false,example: "Random location for the test"},
                        address_type: { type: :string,nullable:false,example: "Home"}
                      },
                    }
                  },
                },
              },
              meta: {
                type: :object,
                properties: {
                  message: {type: :string,example: "List of all addresses"}
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
