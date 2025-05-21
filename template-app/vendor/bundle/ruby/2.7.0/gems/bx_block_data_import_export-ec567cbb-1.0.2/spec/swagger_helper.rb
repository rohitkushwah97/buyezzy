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
        title: 'bx_block_data_import_export',
        version: '1.0.0',
        description: 'Data Import Export block API'
      },
      servers: [
        {
          url: 'http://localhost:3000'
        }
      ],
      components: {
        schemas: {
          data_import_export_json: {
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :string, nullable: false, example: '1' },
                    type: { type: :string, nullable: false, example: 'account' },
                    attributes: {
                      type: :object,
                      properties: {
                        activated: { type: :boolean, nullable: true, example: 'true' },
                        country_code: { type: :string, nullable: true, example: '91'},
                        email: { type: :string, nullable: true, example: 'test@gmail.com' },
                        first_name: {type: :string, nullable: true, example: 'test'},
                        full_phone_number: { type: :string, nullable: true, example: 'test' },
                        last_name: {type: :string, nullable: true, example: 'test'},
                        phone_number: {type: :string, nullable: true, example: '9999999999'},
                        type: {type: :string, nullable: true, example: 'test'},
                        created_at: { type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55' },
                        updated_at: { type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55' }
                      }
                    }
                  }
                }
              }
            }
          },
          data_import_export_csv: {
            type: :string,
            example: 'id,first_name,last_name,full_phone_number,country_code,phone_number,email,activated,device_id,type,created_at,updated_at,user_name,platform,user_type,app_language_id,last_visit_at,is_blacklisted\n41,,,\"\",,,email-1@acme.com,false,,EmailAccount,2023-03-13 08:05:25 UTC,2023-03-13 08:05:25 UTC,test_123,,,,,false\n42,,,\"\",,,email-2@acme.com,false,,EmailAccount,2023-03-13 08:05:25 UTC,2023-03-13 08:05:25 UTC,test_1234,,,,,false\n43,,,\"\",,,email-3@acme.com,false,,EmailAccount,2023-03-13 08:05:25 UTC,2023-03-13 08:05:25 UTC,test_12345,,,,,false\n44,,,\"\",,,email-4@acme.com,false,,EmailAccount,2023-03-13 08:05:25 UTC,2023-03-13 08:05:25 UTC,test_123456,,,,,false\n45,,,\"\",,,email-5@acme.com,false,,EmailAccount,2023-03-13 08:05:25 UTC,2023-03-13 08:05:25 UTC,test_12,,,,,false\n'
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
