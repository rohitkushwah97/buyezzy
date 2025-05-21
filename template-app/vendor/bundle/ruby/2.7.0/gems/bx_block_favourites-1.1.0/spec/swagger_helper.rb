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
        title: 'bx_block_favourites',
        version: '1.0.0',
        description: 'Favourites block API'
      },
      servers: [
        {
          url: 'http://localhost:3000'
        }
      ],
      components: {
        schemas: {
          favourite: {
            type: :object,
            properties: {
              id: { type: :string, nullable: false, example: '2' },
              type: { type: :string, nullable: false, example: 'favourite' },
              attributes: {
                type: :object,
                properties: {
                  favouriteable_id: { type: :string, nullable: false, example: '1' },
                  favouriteable_type: { type: :string, nullable: true, example: 'AccountBlock::Account' },
                  user_id: { type: :string, nullable: false, example: '3' },
                  created_at: { type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55' },
                  updated_at: { type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55' }
                }
              }
            }
          },
          favourite_record_not_found: {
            type: :object,
            properties: {
              message: { type: :string, example: 'Record not found' }
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
