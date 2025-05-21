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
        title: "bx_block_terms_and_conditions",
        version: "1.0.0",
        description: "Terms and Conditions block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          terms_and_condition_id: {
            type: :object,
            properties: {
              id: { type: :integer, nullable: false, example: 1 },
              type: { type: :string, nullable: false, example: "terms_and_conditions" },
              attributes: {
                type: :object,
                properties: {
                  id: { type: :integer, nullable: false, example: 2 }
                }
              }
            }
          },
          terms_and_condition: {
            type: :object,
            properties: {
              id: { type: :integer, nullable: false, example: 1 },
              type: { type: :string, nullable: false, example: "terms_and_conditions" },
              attributes: {
                type: :object,
                properties: {
                  id: { type: :integer, nullable: false, example: 2 },
                  description: { type: :string, nullable: false, example: "Description goes here" },
                  account_id: { type: :integer, nullable: false, example: 2 },
                  created_at: { type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55" },
                  updated_at: { type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55" }
                }
              }
            }
          },
          terms_and_condition_list: {
            type: :object,
            properties: {
              id: { type: :integer, nullable: false, example: 1 },
              type: { type: :string, nullable: false, example: "terms_and_conditions" },
              attributes: {
                type: :object,
                properties: {
                  id: { type: :integer, nullable: false, example: 2 },
                  description: { type: :string, nullable: false, example: "Description goes here" },
                  created_at: { type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55" }
                }
              }
            }
          },
          user_terms_and_condition:{
            type: :object,
            properties: {
              id: { type: :integer, nullable: false, example: 1 },
              type: { type: :string, nullable: false, example: "user_terms_and_condition" },
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer, nullable: false, example: 2 },
                  account_id: { type: :integer, nullable: false, example: 1 },
                  terms_and_condition_id: { type: :integer, nullable: false, example: 1 },
                  is_accepted: { type: :boolean, nullable: false, example: true },
                  created_at: { type: :string, format: :datetime, nullable: true, example: "2023-02-11 10:29:55" },
                  updated_at: { type: :string, format: :datetime, nullable: true, example: "2023-02-11 10:29:55" }
                }
              }
            }
          },
          terms_and_condition_latest_record:{
            type: :object,
            properties: {
              id: { type: :integer, nullable: false, example: 1 },
              type: { type: :string, nullable: false, example: "terms_and_condition" },
              attributes: {
                type: :object,
                properties: {
                  id: { type: :integer, nullable: false, example: 1 },
                  is_accepted: { type: :boolean, nullable: false, example: true },
                  account_id: { type: :integer, nullable: false, example: 2 },
                  description: { type: :string, nullable: false, example: "description goes here" }
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
