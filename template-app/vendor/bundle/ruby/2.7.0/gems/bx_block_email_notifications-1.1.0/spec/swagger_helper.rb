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
        title: 'bx_block_email_notifications',
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
          email_notification: {
            type: :object,
            properties: {
              id: { type: :string, example: '1' },
              type: { type: :string, example: 'email_notification' },
              attributes: {
                type: :object,
                properties: {
                  id: { type: :integer, example: 1 },
                  notification: {
                    type: :object,
                    properties: {
                      id: { type: :integer, example: 1 },
                      created_by: { type: :integer, example: 1 },
                      headings: { type: :string, example: 'Headings' },
                      contents: { type: :string, example: 'Contents' },
                      app_url: { type: :string, example: 'https://www.example.com' },
                      is_read: { type: :boolean, example: false },
                      read_at: { type: :string, example: '2020-02-20T00:00:00.000Z' },
                      account_id: { type: :integer, example: 1 },
                      created_at: { type: :string, example: '2020-02-20T00:00:00.000Z' },
                      updated_at: { type: :string, example: '2020-02-20T00:00:00.000Z' }
                    }
                  },
                  created_at: { type: :string, example: '2020-02-20T00:00:00.000Z' },
                  updated_at: { type: :string, example: '2020-02-20T00:00:00.000Z' },
                  send_to_email: { type: :string, example: 'asdf@example.com' },
                  sent_at: { type: :string, example: '2020-02-20T00:00:00.000Z' }
                }
              }
            }
          }
        }
      }
    }
  }

  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :json
end
