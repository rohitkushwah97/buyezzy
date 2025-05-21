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
        title: "bx_block_comments",
        version: "1.0.0",
        description: "Comments block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          comment:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable:false,example:"1"},
                  type: {type: :string,nullable:false,example:"comment"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable:false,example:1},
                      account_id: {type: :integer,nullable:false,example:1},
                      commentable_id: { type: :integer,nullable:false,example:1},
                      commentable_type: {type: :string,nullable:false,example:"BxBlockPosts::Post"},
                      comment: { type: :string,nullable:false,example:"good"},
                      created_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                      updated_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                      commentable: {
                        type: :object,
                        properties: {
                          id: {type: :integer,nullable:false,example:1},
                          name: {type: :string,nullable:true,example:"test"},
                          description: {type: :string,nullable:true,example:"test description"},
                          category_id: {type: :integer,nullable:true,example:1},
                          created_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                          updated_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                          body: {type: :string,nullable:true,example:"hello"},
                          location: {type: :string,nullable:true,example: "test location"},
                          account_id: {type: :integer,nullable:true,example:1}
                        },
                      },
                      account: {
                        type: :object,
                        properties: {
                          id: {type: :integer,nullable:true,example:1},
                          first_name: {type: :string,nullable:true,example:"first name"},
                          last_name: {type: :string,nullable:true,example:"last name"},
                          full_phone_number: {type: :string,nullable:true,example:"13109541009"},
                          country_code: {type: :number,nullable:true,example:1},
                          phone_number: {type: :number,nullable:true,example:13109541009},
                          email: {type: :string,nullable:true,example:"test@gmail.com"},
                          activated: {type: :boolean,nullable:true,example:true},
                          device_id: {type: :string,nullable:true,example:"dsfdf"},
                          unique_auth_id: {type: :string,nullable:true,example:"L3YEmz0MVRozxkaCQrqZiwtt"},
                          password_digest: {type: :string,nullable:true,example: "$2a$12$PBfGN5.Z80EiFhkNX.kVe.sJctCxpfpwsnqtoqKD3qQ6kf9yq40gu"},
                          created_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                          updated_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                          user_name: {type: :string,nullable:true,example:"user name"},
                          platform: {type: :string,nullable:true,example:"ds"},
                          user_type: {type: :string,nullable:true,example:"dd"},
                          app_language_id: {type: :integer,nullable:true,example:21},
                          is_blacklisted: {type: :boolean,nullable:true,example:true},
                          stripe_id: {type: :string,nullable:true,example:"dd"},
                          stripe_subscription_id: {type: :string,nullable:true,example:"ddssa"},
                          stripe_subscription_date: {type: :string, format: :datetime,nullable:true,example:"asds"},
                          status: {type: :string, nullable:true, example: "regular"}
                        }
                      }
                    }
                  }
                }
              },
              meta: {
                type: :object,
                properties: {
                  success: {type: :boolean,nullable:true,example:true},
                  message: {type: :string,nullable:false,example:"Comment created."}
                },
              },
            },
          },
          comments_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable:false,example:"1"},
                    type: {type: :string,nullable:false,example:"comment"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable:false,example:1},
                        account_id: {type: :integer,nullable:false,example:1},
                        commentable_id: { type: :integer,nullable:false,example:1},
                        commentable_type: {type: :string,nullable:false,example:"BxBlockPosts::Post"},
                        comment: { type: :string,nullable:false,example:"good"},
                        created_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                        updated_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                        commentable: {
                          type: :object,
                          properties: {
                            id: {type: :integer,nullable:false,example:1},
                            name: {type: :string,nullable:true,example:"test"},
                            description: {type: :string,nullable:true,example:"test description"},
                            category_id: {type: :integer,nullable:true,example:1},
                            created_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                            updated_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                            body: {type: :string,nullable:true,example:"hello"},
                            location: {type: :string,nullable:true,example: "test location"},
                            account_id: {type: :integer,nullable:true,example:1}
                          },
                        },
                        account: {
                          type: :object,
                          properties: {
                            id: {type: :integer,nullable:true,example:1},
                            first_name: {type: :string,nullable:true,example:"first name"},
                            last_name: {type: :string,nullable:true,example:"last name"},
                            full_phone_number: {type: :string,nullable:true,example:"13109541009"},
                            country_code: {type: :number,nullable:true,example:1},
                            phone_number: {type: :number,nullable:true,example:13109541009},
                            email: {type: :string,nullable:true,example:"test@gmail.com"},
                            activated: {type: :boolean,nullable:true,example:true},
                            device_id: {type: :string,nullable:true,example:"dsfdf"},
                            unique_auth_id: {type: :string,nullable:true,example:"L3YEmz0MVRozxkaCQrqZiwtt"},
                            password_digest: {type: :string,nullable:true,example: "$2a$12$PBfGN5.Z80EiFhkNX.kVe.sJctCxpfpwsnqtoqKD3qQ6kf9yq40gu"},
                            created_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                            updated_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                            user_name: {type: :string,nullable:true,example:"user name"},
                            platform: {type: :string,nullable:true,example:"ds"},
                            user_type: {type: :string,nullable:true,example:"dd"},
                            app_language_id: {type: :integer,nullable:true,example:21},
                            is_blacklisted: {type: :boolean,nullable:true,example:true},
                            stripe_id: {type: :string,nullable:true,example:"dd"},
                            stripe_subscription_id: {type: :string,nullable:true,example:"ddssa"},
                            stripe_subscription_date: {type: :string, format: :datetime,nullable:true,example:"asds"},
                            status: {type: :string, nullable:true, example: "regular"}
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          comment_update:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable:false,example:"1"},
                  type: {type: :string,nullable:false,example:"comment"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable:false,example:1},
                      account_id: {type: :integer,nullable:false,example:1},
                      commentable_id: { type: :integer,nullable:false,example:1},
                      commentable_type: {type: :string,nullable:false,example:"BxBlockPosts::Post"},
                      comment: { type: :string,nullable:false,example:"good"},
                      created_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                      updated_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                      commentable: {
                        type: :object,
                        properties: {
                          id: {type: :integer,nullable:false,example:1},
                          name: {type: :string,nullable:true,example:"test"},
                          description: {type: :string,nullable:true,example:"test description"},
                          category_id: {type: :integer,nullable:true,example:1},
                          created_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                          updated_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                          body: {type: :string,nullable:true,example:"hello"},
                          location: {type: :string,nullable:true,example: "test location"},
                          account_id: {type: :integer,nullable:true,example:1}
                        },
                      },
                      account: {
                        type: :object,
                        properties: {
                          id: {type: :integer,nullable:true,example:1},
                          first_name: {type: :string,nullable:true,example:"first name"},
                          last_name: {type: :string,nullable:true,example:"last name"},
                          full_phone_number: {type: :string,nullable:true,example:"13109541009"},
                          country_code: {type: :number,nullable:true,example:1},
                          phone_number: {type: :number,nullable:true,example:13109541009},
                          email: {type: :string,nullable:true,example:"test@gmail.com"},
                          activated: {type: :boolean,nullable:true,example:true},
                          device_id: {type: :string,nullable:true,example:"dsfdf"},
                          unique_auth_id: {type: :string,nullable:true,example:"L3YEmz0MVRozxkaCQrqZiwtt"},
                          password_digest: {type: :string,nullable:true,example: "$2a$12$PBfGN5.Z80EiFhkNX.kVe.sJctCxpfpwsnqtoqKD3qQ6kf9yq40gu"},
                          created_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                          updated_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                          user_name: {type: :string,nullable:true,example:"user name"},
                          platform: {type: :string,nullable:true,example:"ds"},
                          user_type: {type: :string,nullable:true,example:"dd"},
                          app_language_id: {type: :integer,nullable:true,example:21},
                          is_blacklisted: {type: :boolean,nullable:true,example:true},
                          stripe_id: {type: :string,nullable:true,example:"dd"},
                          stripe_subscription_id: {type: :string,nullable:true,example:"ddssa"},
                          stripe_subscription_date: {type: :string, format: :datetime,nullable:true,example:"asds"},
                          status: {type: :string, nullable:true, example: "regular"}
                        }
                      }
                    }
                  }
                }
              },
              meta: {
                type: :object,
                properties: {
                  success: {type: :boolean,nullable:true,example:true},
                  message: {type: :string,nullable:false,example:"Comment updated."}
                },
              },
            },
          },
          comment_show:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable:false,example:"1"},
                  type: {type: :string,nullable:false,example:"comment"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable:false,example:1},
                      account_id: {type: :integer,nullable:false,example:1},
                      commentable_id: { type: :integer,nullable:false,example:1},
                      commentable_type: {type: :string,nullable:false,example:"BxBlockPosts::Post"},
                      comment: { type: :string,nullable:false,example:"good"},
                      created_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                      updated_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                      commentable: {
                        type: :object,
                        properties: {
                          id: {type: :integer,nullable:false,example:1},
                          name: {type: :string,nullable:true,example:"test"},
                          description: {type: :string,nullable:true,example:"test description"},
                          category_id: {type: :integer,nullable:true,example:1},
                          created_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                          updated_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                          body: {type: :string,nullable:true,example:"hello"},
                          location: {type: :string,nullable:true,example: "test location"},
                          account_id: {type: :integer,nullable:true,example:1}
                        },
                      },
                      account: {
                        type: :object,
                        properties: {
                          id: {type: :integer,nullable:true,example:1},
                          first_name: {type: :string,nullable:true,example:"first name"},
                          last_name: {type: :string,nullable:true,example:"last name"},
                          full_phone_number: {type: :string,nullable:true,example:"13109541009"},
                          country_code: {type: :number,nullable:true,example:1},
                          phone_number: {type: :number,nullable:true,example:13109541009},
                          email: {type: :string,nullable:true,example:"test@gmail.com"},
                          activated: {type: :boolean,nullable:true,example:true},
                          device_id: {type: :string,nullable:true,example:"dsfdf"},
                          unique_auth_id: {type: :string,nullable:true,example:"L3YEmz0MVRozxkaCQrqZiwtt"},
                          password_digest: {type: :string,nullable:true,example: "$2a$12$PBfGN5.Z80EiFhkNX.kVe.sJctCxpfpwsnqtoqKD3qQ6kf9yq40gu"},
                          created_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                          updated_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                          user_name: {type: :string,nullable:true,example:"user name"},
                          platform: {type: :string,nullable:true,example:"ds"},
                          user_type: {type: :string,nullable:true,example:"dd"},
                          app_language_id: {type: :integer,nullable:true,example:21},
                          is_blacklisted: {type: :boolean,nullable:true,example:true},
                          stripe_id: {type: :string,nullable:true,example:"dd"},
                          stripe_subscription_id: {type: :string,nullable:true,example:"ddssa"},
                          stripe_subscription_date: {type: :string, format: :datetime,nullable:true,example:"asds"},
                          status: {type: :string, nullable:true, example: "regular"}
                        }
                      }
                    }
                  }
                }
              },
              meta: {
                type: :object,
                properties: {
                  success: {type: :boolean,nullable:true,example:true},
                  message: {type: :string,nullable:false,example:"Comment details."}
                },
              },
            },
          },
          comments_search:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable:false,example:"1"},
                    type: {type: :string,nullable:false,example:"comment"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable:false,example:1},
                        account_id: {type: :integer,nullable:false,example:1},
                        commentable_id: { type: :integer,nullable:false,example:1},
                        commentable_type: {type: :string,nullable:false,example:"BxBlockPosts::Post"},
                        comment: { type: :string,nullable:false,example:"good"},
                        created_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                        updated_at: {type: :string,nullable:false,example:"2023-04-17T06:33:14.357Z"},
                        commentable: {
                          type: :object,
                          properties: {
                            id: {type: :integer,nullable:false,example:1},
                            name: {type: :string,nullable:true,example:"test"},
                            description: {type: :string,nullable:true,example:"test description"},
                            category_id: {type: :integer,nullable:true,example:1},
                            created_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                            updated_at: {type: :string,nullable:true,example:"2023-04-17T06:33:14.357Z"},
                            body: {type: :string,nullable:true,example:"hello"},
                            location: {type: :string,nullable:true,example: "test location"},
                            account_id: {type: :integer,nullable:true,example:1}
                          },
                        },
                        account: {
                          type: :object,
                          properties: {
                            id: {type: :integer,nullable:true,example:1},
                            first_name: {type: :string,nullable:true,example:"first name"},
                            last_name: {type: :string,nullable:true,example:"last name"},
                            full_phone_number: {type: :string,nullable:true,example:"13109541009"},
                            country_code: {type: :number,nullable:true,example:1},
                            phone_number: {type: :number,nullable:true,example:13109541009},
                            email: {type: :string,nullable:true,example:"test@gmail.com"},
                            activated: {type: :boolean,nullable:true,example:true},
                            device_id: {type: :string,nullable:true,example:"dsfdf"},
                            unique_auth_id: {type: :string,nullable:true,example:"L3YEmz0MVRozxkaCQrqZiwtt"},
                            password_digest: {type: :string,nullable:true,example: "$2a$12$PBfGN5.Z80EiFhkNX.kVe.sJctCxpfpwsnqtoqKD3qQ6kf9yq40gu"},
                            created_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                            updated_at: {type: :string,nullable:true,example:"2023-04-17T05:21:12.477Z"},
                            user_name: {type: :string,nullable:true,example:"user name"},
                            platform: {type: :string,nullable:true,example:"ds"},
                            user_type: {type: :string,nullable:true,example:"dd"},
                            app_language_id: {type: :integer,nullable:true,example:21},
                            is_blacklisted: {type: :boolean,nullable:true,example:true},
                            stripe_id: {type: :string,nullable:true,example:"dd"},
                            stripe_subscription_id: {type: :string,nullable:true,example:"ddssa"},
                            stripe_subscription_date: {type: :string, format: :datetime,nullable:true,example:"asds"},
                            status: {type: :string, nullable:true, example: "regular"}
                          }
                        }
                      }
                    }
                  }
                }
              },
               meta: {
                type: :object,
                properties: {
                  success: {type: :boolean,nullable:true,example:true},
                  message: {type: :string,nullable:false,example:"Comment details."}
                },
              },
            }
          },
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
