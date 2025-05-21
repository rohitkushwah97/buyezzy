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
      openapi: '3.0.1',
      info: {
        title: "bx_block_activity_feed",
        version: "1.0.0",
        description: "Activity Feed block API"
      },
      servers: [
        {
          url: 'http://localhost:3000'
        }
      ],
      paths: {},
      components: {
        schemas: {
          activity_feed: {
             type: :object,
          properties: {
            activities: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: {type: :integer,nullable: true, example: '1'},
                  trackable_type: {type: :string,nullable: true, example: 'test'},
                  trackable_id: {type: :integer,nullable: true, example: 'test'},
                  owner_type: {type: :string,nullable: true, example: 'test'},
                  owner_id: {type: :integer,nullable: true, example: 'test'},
                  key: {type: :string,nullable: true, example: 'test'},
                  parameters: {type: :object,nullable: true, example: 'test'},
                  recipient_type: {type: :string,nullable: true, example: 'test'},
                  recipient_id: {type: :string,nullable: true, example: 'test'},
                  created_at: {type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55'},
                  updated_at: {type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55'},
                  trackable: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable: true, example: '1'},
                      first_name: {type: :string,nullable: true, example: 'name'},
                      last_name: {type: :string,nullable: true, example: 'name'},
                      full_phone_number: {type: :string,nullable: true, example: 'number'},
                      country_code: {type: :string,nullable: true, example: 'country'},
                      phone_number: {type: :string,nullable: true, example: 'phone'},
                      email: {type: :string,nullable: true, example: 'email'},
                      activated: {type: :boolean,nullable: true, example: 'test'},
                      device_id: {type: :string,nullable: true, example: 'test'},
                      unique_auth_id: {type: :string,nullable: true, example: 'test'},
                      password_digest: {type: :string,nullable: true, example: 'password'},
                      created_at: {type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55'},
                      updated_at: {type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55'},
                      user_name: {type: :string,nullable: true, example: 'user'},
                      platform: {type: :string,nullable: true, example: 'test'},
                      user_type: {type: :string,nullable: true, example: 'user'},
                      app_language_id: {type: :string,nullable: true,example: "language_id"},
                      last_visit_at: {type: :string,nullable: true, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                      is_blacklisted: {type: :boolean, example: 'test'},
                      stripe_id: {type: :string,nullable: true, example: 'stripe'},
                      stripe_subscription_id: {type: :string,nullable: true, example: 'test'},
                      stripe_subscription_date: {type: :string,nullable: true, example: 'test'}
                    }
                  },
                  owner: {
                    type: :object,
                    nullable: true,
                    properties: {
                      id: {type: :integer,nullable: true, example: '1'},
                      first_name: {type: :string,nullable: true, example: 'name'},
                      last_name: {type: :string,nullable: true, example: 'name'},
                      full_phone_number: {type: :string,nullable: true, example: 'number'},
                      country_code: {type: :string,nullable: true, example: 'country'},
                      phone_number: {type: :string,nullable: true, example: 'phone'},
                      email: {type: :string,nullable: true, example: 'email'},
                      activated: {type: :boolean,nullable: true, example: 'test'},
                      device_id: {type: :string,nullable: true, example: 'test'},
                      unique_auth_id: {type: :string,nullable: true, example: 'test'},
                      password_digest: {type: :string,nullable: true, example: 'password'},
                      created_at: {type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55'},
                      updated_at: {type: :string, format: :datetime, nullable: true, example: '2022-12-17 10:29:55'},
                      user_name: {type: :string,nullable: true, example: 'name'},
                      platform: {type: :string,nullable: true, example: 'test'},
                      user_type: {type: :string,nullable: true, example: 'user'},
                      app_language_id: {type: :string,nullable: true, example: 'language_id'},
                      last_visit_at: {type: :string,nullable: true, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                      is_blacklisted: {type: :boolean,nullable: true, example: 'test'},
                      stripe_id: {type: :string,nullable: true, example: 'stripe'},
                      stripe_subscription_id: {type: :string,nullable: true, example: 'test'},
                      stripe_subscription_date: {type: :string,nullable: true, example: 'test'}
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