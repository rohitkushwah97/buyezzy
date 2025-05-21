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
        title: 'bx_block_help_centre',
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
          question_answer: {
            type: :object,
            properties: {
              id: { type: :string, nullable: false, example: '1' },
              type: { type: :string, nullable: false, example: 'question_answer' },
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer, example: 1},
                  question: {type: :string, example: "question"},
                  answer: {type: :string, example: "answer"},
                  created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                  updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"}
                }
              }
            }
          },
          question_sub_type: {
            type: :object,
            properties: {
              id: { type: :string, nullable: false, example: '1' },
              type: { type: :string, nullable: false, example: 'question_sub_type' },
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer, example: 1},
                  sub_type: {type: :string, example: "sub_type"},
                  description: {type: :string, example: "description"},
                  created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                  updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                  question_answers: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        id: {type: :integer, example: 1},
                        question: {type: :string, example: "question"},
                        answer: {type: :string, example: "answer"},
                        created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                        updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"}
                      }
                    }
                  }
                }
              }
            }
          },
          question_type: {
            type: :object,
            properties: {
              id: { type: :string, nullable: false, example: '1' },
              type: { type: :string, nullable: false, example: 'question_type' },
              attributes: {
                type: :object,
                properties: {
                  id: {type: :integer, example: 1},
                  que_type: {type: :string, example: "que_type"},
                  description: {type: :string, example: "description"},
                  created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                  updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                  question_sub_types: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        id: { type: :string, nullable: false, example: '1' },
                        type: { type: :string, nullable: false, example: 'question_sub_type' },
                        attributes: {
                          type: :object,
                          properties: {
                            id: {type: :integer, example: 1},
                            sub_type: {type: :string, example: "sub_type"},
                            description: {type: :string, example: "description"},
                            created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                            updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                            question_answers: {
                              type: :array,
                              items: {
                                type: :object,
                                properties: {
                                  id: {type: :integer, example: 1},
                                  question: {type: :string, example: "question"},
                                  answer: {type: :string, example: "answer"},
                                  created_at: {type: :string, example: "2020-07-07T09:00:00.000Z"},
                                  updated_at: {type: :string, example: "2020-07-07T09:00:00.000Z"}
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
