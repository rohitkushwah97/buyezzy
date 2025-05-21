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
        title: "bx_block_roles_permissions",
        version: "1.0.0",
        description: "Roles and Permissions block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          accounts: {
            type: :object,
            properties: {
              id: {type: :integer, example: 1},
              type: {type: :string, example: "account"},
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer, example: 1},
                  activated: {type: :boolean, example: true},
                  country_code: {type: :string, example: "IND"},
                  email: {type: :string, example: "test1@test.com"},
                  first_name: {type: :string, example: "first"},
                  full_phone_number: {type: :string, example: "+911234567890"},
                  last_name: {type: :string, example: "last"},
                  phone_number: {type: :string, example: "123456789"},
                  type: {type: :string, example: "EmailAccount"},
                  created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                  device_id: {type: :string, example: "drt567yh"},
                  unique_auth_id: {type: :string, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"}

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
