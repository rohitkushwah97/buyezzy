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
        title: "bx_block_categories",
        version: "1.0.0",
        description: "Category block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          category: {
            type: :object,
            properties: {
              id: {type: :string, nullable: false, example: "1"},
              type: {type: :string, nullable: false, example: "category"},
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer, nullable: false, example: 2},
                  name: {type: :string, nullable: true, example: "Category-1"},
                  dark_icon: {type: :string, nullable: true, example: "http://test.com"},
                  dark_icon_active: {type: :string, nullable: true, example: "http://test.com"},
                  dark_icon_inactive: {type: :string, nullable: true, example: "http://test.com"},
                  light_icon: {type: :string, nullable: true, example: "http://test.com"},
                  light_icon_active: {type: :string, nullable: true, example: "http://test.com"},
                  light_icon_inactive: {type: :string, nullable: true, example: "http://test.com"},
                  rank: {type: :string, nullable: true, example: "1"},
                  created_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                  updated_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                  sub_categories: {
                    type: :array,
                    items: {
                      type: :integer
                    },
                    example: [1, 2]
                  },
                  selected_sub_categories: {type: :string, nullable: true, example: "1"}
                }
              }
            }
          },
          sub_category: {
            type: :object,
            properties: {
              id: {type: :string, nullable: false, example: "1"},
              type: {type: :string, nullable: false, example: "category"},
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer, nullable: false, example: 1},
                  name: {type: :string, nullable: true, example: "Category-1"},
                  created_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                  updated_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"}
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
