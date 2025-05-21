# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'bx_block_block_users',
        version: '0.1.0'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ],
      components: {
        schemas: {
          block_user: {
            type: :object,
            properties: {
              id: { type: :string, nullable: false, example: '1' },
              type: { type: :string, nullable: false, example: 'block_user' },
              attributes: {
                type: :object,
                properties: {
                  current_user_id: {type: :string, example: "1"},
                  account_id: {type: :string, example: "1"},
                  created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                  updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                  account: {
                    type: :object,
                    properties: {
                      id: {type: :string, example: "1"},
                      first_name: {type: :string, example: "John"},
                      last_name: {type: :string, example: "Doe"},
                      full_phone_number: {type: :string, example: "+447123456789"},
                      country_code: {type: :string, example: "GB"},
                      phone_number: {type: :string, example: "7123456789"},
                      email: {type: :string, example: "asdf@example.com"},
                      activated: {type: :boolean, example: true},
                      device_id: {type: :string, example: "1234567890"},
                      unique_auth_id: {type: :string, example: "1234567890"},
                      password_digest: {type: :string, example: "1234567890"},
                      created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                      updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                      user_name: {type: :string, example: "JohnDoe"},
                      platform: {type: :string, example: "ios"},
                      user_type: {type: :string, example: "user"},
                      app_language_id: {type: :string, example: "1"},
                      last_visit_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                      is_blacklisted: {type: :boolean, example: false},
                      suspend_until: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                      status: {type: :string, example: "active"}
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
  config.swagger_format = :json
end
