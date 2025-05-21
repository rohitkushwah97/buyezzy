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
        title: "bx_block_profile_bio",
        version: "1.0.0",
        description: "Profile Bio block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          profile_bio: {
            type: :object,
            properties: {
              id: {type: :string, nullable: false, example: "1"},
              type: {type: :string, nullable: false, example: "profile_bio"},
              attributes: {
                type: :object,
                properties: {
                  account_id: {type: :integer, nullable: false, example: 1},
                  height: {type: :string, nullable: true, example: "5.5"},
                  weight: {type: :string, nullable: true, example: "50"},
                  height_type: {type: :string, nullable: true, example: "foot"},
                  weight_type: {type: :string, nullable: true, example: "kg"},
                  body_type: {type: :string, nullable: true, example: "Athletic"},
                  mother_tougue: {type: :string, nullable: true, example: "English"},
                  religion: {type: :string, nullable: true, example: "Jain"},
                  zodiac: {type: :string, nullable: true, example: "Taurus"},
                  marital_status: {type: :string, nullable: true, example: "Single"},
                  languages: {
                    type: :array,
                    items: {
                      type: :string
                    },
                    example: ["test1", "test2", "test3"]
                  },
                  about_me: {type: :string, nullable: true, example: "Famous for wearing no socks in cold weather"},
                  personality: {
                    type: :array,
                    items: {
                      type: :string
                    },
                    example: ["Extrovert", "Introvert", "Angry"]
                  },
                  interests: {
                    type: :array,
                    items: {
                      type: :string
                    },
                    example: ["Sports", "Fitness"]
                  },
                  smoking: {type: :string, nullable: true, example: "No"},
                  drinking: {type: :string, nullable: true, example: "No"},
                  custom_attributes: {type: :string, nullable: true, example: "custom_attributes"},
                  looking_for: {type: :integer, nullable: true, example: 0},
                  created_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"},
                  updated_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"},
                  educations: {
                    type: :array,
                    items: {
                      type: :integer
                    },
                    example: [1, 2]
                  },
                  achievements: {
                    type: :array,
                    items: {
                      type: :integer
                    },
                    example: [1, 2]
                  },
                  careers: {
                    type: :array,
                    items: {
                      type: :integer
                    },
                    example: [1, 2]
                  },
                  account: {
                    type: :object,
                    properties: {
                      id: {type: :integer, nullable: false, example: 1},
                      first_name: {type: :string, nullable: false, example: "first"},
                      last_name: {type: :string, nullable: false, example: "last"},
                      full_phone_number: {type: :string, nullable: true, example: "+91123456790"},
                      country_code: {type: :string, nullable: true, example: "IND"},
                      phone_number: {type: :string, nullable: true, example: "123456789"},
                      email: {type: :string, nullable: false,  example: "test1@test.com"},
                      activated: {type: :boolean, example: true},
                      device_id: {type: :string, nullable: true, example: "EmailAccount"},
                      unique_auth_id: {type: :string, nullable: true, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"},
                      password_digest: {type: :string, nullable: true, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"},
                      created_at: {type: :string, format: :datetime, nullable: true, example: "2023-01-30T06:32:31.563Z"},
                      updated_at: {type: :string, format: :datetime, nullable: true, example: "2023-01-30T06:32:31.563Z"},
                      gender: {type: :integer, nullable: true, example: 1},
                      date_of_birth: {type: :string,format: :date, example: "1998-01-01"},
                      age: {type: :integer, nullable: false, example: 20},
                      is_blacklisted: {type: :boolean, example: false}
                    }
                  }
                }
              }
            }
          },
          fetch_interests: {
            type: :array,
            items: {
              type: :string
            },
            example: [
              "Sports",
              "Fitness",
              "Cooking",
              "Traveling",
              "Politics",
              "Adventures",
              "Music",
              "Pets",
              "Mountains",
              "Beaches",
              "Cooking",
              "Nature",
              "Photography",
              "Dancing",
              "Painting",
              "Pets",
              "Music",
              "Puzzles",
              "Gardening",
              "Reading Books",
              "Handicrafts",
              "Movies",
              "Night Outs",
              "Stargazing",
              "Internet",
              "Surfing",
              "Traveling",
              "Chit Chat",
              "Sports",
              "Adventures",
              "Trekking",
              "Hiking",
              "Yoga",
              "Workouts",
              "Baking",
              "Binge-Watching",
              "Calligraphy",
              "Blogging",
              "Writing",
              "Drama",
              "Home Improving",
              "Journaling",
              "Knitting",
              "Martial Arts",
              "Miniature Art",
              "Poetry",
              "Sewing",
              "Sketching",
              "Singing",
              "Video Gaming",
              "Wood Carving",
              "Astronomy",
              "Bird Watching",
              "Fishing",
              "Swimming",
              "Nature"
            ]
          },
          fetch_personalities: {
            type: :array,
            items: {
              type: :string
            },
            example: [
              "Extrovert",
              "Introvert",
              "Creative",
              "Angry",
              "Cool",
              "Emotional",
              "Practical",
              "Rules Breaker",
              "Stick To Rules",
              "Optimistic",
              "Pessimist",
              "Hard Work",
              "Smart Work",
              "Spendthrift",
              "Miser",
              "Good Listener",
              "Talks a Lot",
              "Childish",
              "Matured",
              "Patient",
              "Impatient",
              "Competitive",
              "Relaxed",
              "Last-Minute Person",
              "Pre-Planner",
              "Foodie",
              "Book Bug",
              "Shopaholic",
              "Morning Person",
              "Night Owl"
            ]
          },
          preference: {
            type: :object,
            properties: {
              id: {type: :string, nullable: false, example: "1"},
              type: {type: :string, nullable: false, example: "profile_bio"},
              attributes: {
                type: :object,
                properties: {
                  account_id: {type: :integer, nullable: false, example: 1},
                  seeking: {type: :string, nullable: true, example: "Male"},
                  location: {type: :string, nullable: false, example: "test"},
                  distance: {type: :integer, nullable: false, example: 50},
                  age_range_start: {type: :integer, nullable: false, example: 18},
                  age_range_end: {type: :integer, nullable: false, example: 50},
                  height_range_start: {type: :string, nullable: false, example: "5"},
                  height_range_end: {type: :string, nullable: false, example: "6"},
                  height_type: {type: :string, nullable: true, example: "foot"},
                  body_type: {type: :string, nullable: true, example: "Athletic"},
                  religion: {type: :string, nullable: true, example: "Jain"},
                  smoking: {type: :string, nullable: true, example: "No"},
                  drinking: {type: :string, nullable: true, example: "No"},
                  friend: {type: :boolean, nullable: true, example: true},
                  business: {type: :boolean, nullable: true, example: true},
                  match_making: {type: :boolean, nullable: true, example: true},
                  travel_partner: {type: :boolean, nullable: true, example: true},
                  cross_path: {type: :boolean, nullable: true, example: true},
                  created_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"},
                  updated_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"}
                }
              }
            }
          },
          reset_preference: {
            type: :object,
            properties: {
              id: {type: :string, nullable: false, example: "1"},
              type: {type: :string, nullable: false, example: "profile_bio"},
              attributes: {
                type: :object,
                properties: {
                  account_id: {type: :integer, nullable: false, example: 1},
                  seeking: {type: :string, nullable: true, example: nil },
                  location: {type: :string, nullable: true, example: nil },
                  distance: {type: :integer, nullable: true, example: nil },
                  age_range_start: {type: :integer, nullable: true, example: nil },
                  age_range_end: {type: :integer, nullable: true, example: nil },
                  height_range_start: {type: :string, nullable: true, example: nil },
                  height_range_end: {type: :string, nullable: true, example: nil },
                  height_type: {type: :string, nullable: true, example: nil },
                  body_type: {type: :string, nullable: true, example: nil },
                  religion: {type: :string, nullable: true, example: nil },
                  smoking: {type: :string, nullable: true, example: nil },
                  drinking: {type: :string, nullable: true, example: nil },
                  friend: {type: :boolean, nullable: true, example: false },
                  business: {type: :boolean, nullable: true, example: false },
                  match_making: {type: :boolean, nullable: true, example: false },
                  travel_partner: {type: :boolean, nullable: true, example: false },
                  cross_path: {type: :boolean, nullable: true, example: false},
                  created_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"},
                  updated_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"},
                }
              }
            }
          },
          view_profile: {
            type: :object,
            properties: {
              id: {type: :string, nullable: false, example: "1"},
              type: {type: :string, nullable: false, example: "view_profile"},
              attributes: {
                type: :object,
                properties: {
                  account_id: {type: :integer, nullable: false, example: 1},
                  view_by_id: {type: :integer, nullable: false, example: 1},
                  created_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"},
                  updated_at: {type: :string, format: :datetime, nullable: true, example: "2023-02-10 10:29:55"},
                  full_name: { type: :string, nullable: false, example: "first last"},
                  mutual_friends_count: { type: :integer, nullable: true, example: 1}
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
