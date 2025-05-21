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
        title: 'bx_block_filter_items',
        version: '1.0.0',
        description: 'Filter Items block API'
      },
      servers: [
        {
          url: 'http://localhost:3000'
        }
      ],
      paths: {},
      components: {
        schemas: {
          catalogues: {
            type: :object,
            properties: {
              data: {
                type: :array,
                properties: {
                  id: { type: :string, nullable: false, example: '1' },
                  type: { type: :string, nullable: false, example: 'catalogue' },
                  attributes: {
                    type: :object,
                    properties: {
                      category: {
                        type: :object,
                        properties: {
                          id: { type: :string, example: '1' },
                          name: { type: :string, nullable: false, example: 1 },
                          created_at: { type: :string, nullable: false, example: '2022-11-14T14:01:55.210Z' },
                          updated_at: { type: :string, nullable: false, example: '2022-11-14T14:01:55.210Z' },

                          light_icon: {
                            type: :object,
                            items: {}
                          },
                          light_icon_active: {
                            type: :object,
                            items: {}
                          },
                          light_icon_inactive: {
                            type: :object,
                            items: {}
                          },
                          dark_icon: {
                            type: :object,
                            items: {}
                          },
                          dark_icon_active: {
                            type: :object,
                            items: {}
                          },
                          dark_icon_inactive: {
                            type: :object,
                            items: {}
                          }

                        }
                      },
                      sub_category: {
                        type: :object,
                        properties: {
                          id: { type: :integer, example: 1 },
                          name: { type: :string, example: 'sub_category' },
                          created_at: { type: :string, example: '2022-11-14T14:01:55.210Z' },
                          updated_at: { type: :string, example: '2022-11-14T14:01:55.210Z' }

                        }
                      },
                      brand: {
                        type: :object,
                        properties: {
                          id: { type: :integer, example: 1 },
                          name: { type: :string, example: 'brand' },
                          created_at: { type: :string, example: '2022-11-14T14:01:55.210Z' },
                          updated_at: { type: :string, example: '2022-11-14T14:01:55.210Z' },
                          currency: { type: :string, example: 'GBP' }
                        }
                      },
                      tags: {
                        type: :array,
                        items: {}
                      },
                      reviews: {
                        type: :array,
                        items: {}
                      },
                      name: { type: :string, example: 'Catalogue-22' },
                      sku: { type: :string, example: 'sku-1' },
                      description: { type: :string, example: 'First catalogue' },
                      manufacture_date: { type: :string, example: '2020-10-19T14:59:08.817Z' },
                      length: { type: :number, example: 10.5 },
                      breadth: { type: :number, example: 1.5 },
                      height: { type: :number, example: 2 },
                      stock_qty: { type: :integer, example: 10 },
                      availability: { type: :string, example: 'in_stock' },
                      weight: { type: :string, example: '2.2' },
                      price: { type: :number, example: 0.1 },
                      recommended: { type: :boolean, example: true },
                      on_sale: { type: :boolean, example: false },
                      sale_price: { type: :string, example: '0.05' },
                      discount: { type: :string, example: '0.2' },
                      average_rating: { type: :integer, example: 0 },
                      catalogue_variants: {
                        type: :array,
                        items: {}
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
