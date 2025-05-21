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
        title: "bx_block_catalogue",
        version: "1.0.0",
        description: "Catelogue block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          brand:{
            type: :object, 
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string, nullable: false, example: "1"},
                  type: {type: :string, nullable: false, example: "brand"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable: false, example: 1},
                      name: {type: :string,nullable: false, example: "Brand-1"},
                      currency: {type: :string,nullable: false,example: "usd"},
                      created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                      updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                    }
                  }
                }
              }
            }
          },
          brand_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string, nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "brand"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable: false, example: 1},
                        name: {type: :string,nullable: false, example: "Brand-1"},
                        currency: {type: :string,nullable: false,example: "usd"},
                        created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                        updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                      }
                    }
                  }
                }
              }
            }
          },
          tag:{
            type: :object, 
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string, nullable: false, example: "1"},
                  type: {type: :string, nullable: false, example: "tag"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable: false, example: 1},
                      name: {type: :string,nullable: false, example: "tag-1"},
                      created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                      updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                    }
                  }
                }
              }
            }
          },
          tag_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string, nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "tag"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable: false, example: 1},
                        name: {type: :string,nullable: false, example: "tag-1"},
                        created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                        updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                      }
                    }
                  }
                }
              }
            }
          },
          review:{
            type: :object, 
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string, nullable: false, example: "1"},
                  type: {type: :string, nullable: false, example: "review"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable: false, example: 1},
                      catalogue_id: {type: :integer,nullable: false, example: 1},
                      rating: {type: :integer,nullable: false, example: 5},
                      comment: {type: :string,nullable: false, example: "Great Apples"},
                      created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                      updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                    }
                  }
                }
              }
            }
          },
          review_list: {
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string, nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "review"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable: false, example: 1},
                        catalogue_id: {type: :integer,nullable: false, example: 1},
                        rating: {type: :integer,nullable: false, example: 5},
                        comment: {type: :string,nullable: false, example: "Great Apples"},
                        created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                        updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                      }
                    }
                  }
                }
              }
            }
          },
          catalogues_variants_color: {
           type: :object, 
           properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable:false,example:"1"},
                  type: {type: :string,nullable: false,example:"catalogue_variant_color"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable: false, example: 1},
                      name: {type: :string,nullable:false,example:"Catalogue variant color 1"},
                      created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                      updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                    }
                  }
                }
              }
            }
          },
          catalogues_variants_color_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string, nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "catalogue_variant_color"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable: false, example: 1},
                        name: {type: :string,nullable:false,example:"Catalogue variant color 1"},
                        created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                        updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                      }
                    }
                  }
                }
              }
            }
          },
          catalogues_variants_size:{
           type: :object, 
           properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable:false,example:"1"},
                  type: {type: :string,nullable: false,example:"catalogue_variant_size"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable: false, example: 1},
                      name: {type: :string,nullable:false,example:"Catalogue variant color 1"},
                      created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                      updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                    }
                  }
                }
              }
            }
          },
          catalogues_variants_sizes_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string, nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "catalogue_variant_size"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable: false, example: 1},
                        name: {type: :string,nullable:false,example:"Catalogue variant size 1"},
                        created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                        updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"}
                      }
                    }
                  }
                }
              }
            }
          },
          catalogues_variant:{
            type: :object, 
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable:false,example:"1"},
                  type: {type: :string,nullable: false,example:"catalogue_variant"},
                  attributes: {
                    type: :object,
                    properties:{
                      catalogue_id: {type: :integer,example: 1},
                      catalogue_variant_color_id: {type: :integer,example: 1},
                      catalogue_variant_size_id: {type: :integer,example: 1},
                      price: {type: :string,example: "10.5"},
                      stock_qty: {type: :integer,example: 3},
                      on_sale: {type: :boolean,example: true},
                      sale_price: {type: :string,example: "9.0"},
                      discount_price: {type: :string,example: "1.0"},
                      length: {type: :number,example: 3.3},
                      breadth: {type: :number,example: 2.5},
                      height: {type: :number,example: 100},
                      created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                      updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                      # images: {type: :string,nullable: false,example: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--5264a4df96630f63beb37bc238098cb7cb0cae25/1673850691"}

                    }
                  }
                }
              }
            }
          },
          catalogues_variants_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string, nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "catalogue_variant"},
                    attributes: {
                      type: :object,
                      properties: {
                        catalogue_id: {type: :integer,example: 1},
                        catalogue_variant_color_id: {type: :integer,example: 1},
                        catalogue_variant_size_id: {type: :integer,example: 1},
                        price: {type: :string,example: "10.5"},
                        stock_qty: {type: :integer,example: 3},
                        on_sale: {type: :boolean,example: true},
                        sale_price: {type: :string,example: "9.0"},
                        discount_price: {type: :string,example: "1.0"},
                        length: {type: :number,example: 3.3},
                        breadth: {type: :number,example: 2.5},
                        height: {type: :number,example: 100},
                        created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                        updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                        # images: {type: :string,nullable: false,example: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--5264a4df96630f63beb37bc238098cb7cb0cae25/1673850691"}
                      }
                    }
                  }
                }
              }
            }
          },
          catalogues:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable: false, example: "1"},
                  type: {type: :string,nullable: false, example: "catalogue"},
                  attributes: {
                    type: :object,
                    properties: {
                      category: {
                        type: :object,
                        properties: {
                          id: {type: :string , example: "1"},
                          name: {type: :string,nullable: false, example: 1},
                          created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                          updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                          # admin_user_id: {type: :integer,example:1},
                          # rank: {type: :integer,example:5},
                          light_icon: {
                            type: :object,
                            items:{}
                          },
                          light_icon_active: {
                            type: :object,
                            items:{}
                          },
                          light_icon_inactive: {
                            type: :object,
                            items:{}
                          },
                          dark_icon: {
                            type: :object,
                            items:{}
                          },
                          dark_icon_active: {
                            type: :object,
                            items:{}
                          },
                          dark_icon_inactive: {
                            type: :object,
                             items:{}
                          },
                          # identifier: {type: :integer,example:1},
                        }
                      },
                      sub_category: {
                        type: :object,
                        properties: {
                          id: {type: :integer,example:1},
                          name: {type: :string,example: "sub_category"},
                          created_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                          updated_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                          # parent_id: {type: :integer,example:1},
                          # rank: {type: :integer,example:5}
                        }
                      },
                      brand: {
                        type: :object,
                        properties: {
                          id: {type: :integer,example:1},
                          name: {type: :string,example:"brand"},
                          created_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                          updated_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                          currency: {type: :string,example:"GBP"}
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
                      name: {type: :string,example:"Catalogue-22",},
                      sku: {type: :string,example:"sku-1"},
                      description: {type: :string,example:"First catalogue"},
                      manufacture_date: {type: :string,example:"2020-10-19T14:59:08.817Z"},
                      length: {type: :number,example:10.5},
                      breadth: {type: :number,example: 1.5},
                      height: {type: :number,example:2},
                      stock_qty: {type: :integer,example:10},
                      availability: {type: :string,example:"in_stock"},
                      weight: {type: :string,example:"2.2"},
                      price: {type: :number,example:0.1},
                      recommended: {type: :boolean,example:true},
                      on_sale: {type: :boolean,example:false},
                      sale_price: {type: :string,example:"0.05"},
                      discount: {type: :string,example:"0.2"},
                      # images: {
                      #   type: :array,
                      #   items: {
                      #     type: :object,
                      #     properties: {
                      #       id: {type: :integer,example:1},
                      #       url: {
                      #         type: :string,example:"http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--93dcba25966ccfb79aff2dc4a644296348b76248/0E9240F1-46F8-4265-8CD8-A95E79BCC131.jpg"
                      #       }
                      #     },
                      #   }
                      # },
                      average_rating: {type: :integer,example:0},
                      catalogue_variants: {
                        type: :array,
                        items: {}
                      }
                    }
                  }
                }
              }
            }
          },
          catalogues_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable: false, example: "1"},
                    type: {type: :string,nullable: false, example: "catalogue"},
                    attributes: {
                      type: :object,
                      properties: {
                        category: {
                          type: :object,
                          properties: {
                            id: { type: :string, example: "1" },
                            name: {type: :string,nullable: false, example: 1},
                            created_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                            updated_at: {type: :string,nullable: false,example: "2022-11-14T14:01:55.210Z"},
                            light_icon: {
                            type: :object,
                            items:{}
                          },
                          light_icon_active: {
                            type: :object,
                            items:{}
                          },
                          light_icon_inactive: {
                            type: :object,
                            items:{}
                          },
                          dark_icon: {
                            type: :object,
                            items:{}
                          },
                          dark_icon_active: {
                            type: :object,
                            items:{}
                          },
                          dark_icon_inactive: {
                            type: :object,
                             items:{}
                          },
                          # identifier: {type: :integer,example:1},
                          }
                        },
                        sub_category: {
                          type: :object,
                          properties: {
                            id: {type: :integer,example:1},
                            name: {type: :string,example: "sub_category"},
                            created_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                            updated_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                            # parent_id: {type: :integer,example:1},
                            # rank: {type: :integer,example:5}
                          }
                          # items: {}
                        },
                        brand: {
                          type: :object,
                          properties: {
                            id: {type: :integer,example:1},
                            name: {type: :string,example:"brand"},
                            created_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                            updated_at: {type: :string,example:"2022-11-14T14:01:55.210Z"},
                            currency: {type: :string,example:"GBP"}
                          }
                          # items: {}
                        },
                        tags: {
                          type: :array,
                          items: {}
                        },
                        reviews: {
                          type: :array,
                          items: {}
                        },
                        name: {type: :string,example:"Catalogue-22",},
                        sku: {type: :string,example:"sku-1"},
                        description: {type: :string,example:"First catalogue"},
                        manufacture_date: {type: :string,example:"2020-10-19T14:59:08.817Z"},
                        length: {type: :number,example:10.5},
                        breadth: {type: :number,example: 1.5},
                        height: {type: :number,example:2},
                        stock_qty: {type: :integer,example:10},
                        availability: {type: :string,example:"in_stock"},
                        weight: {type: :string,example:"2.2"},
                        price: {type: :number,example:0.1},
                        recommended: {type: :boolean,example:true},
                        on_sale: {type: :boolean,example:false},
                        sale_price: {type: :string,example:"0.05"},
                        discount: {type: :string,example:"0.2"},
                        # images: {
                        #   type: :array,
                        #   items: {
                        #     type: :object,
                        #     properties: {
                        #       id: {type: :integer,example:1},
                        #       url: {
                        #         type: :string,example:"http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--93dcba25966ccfb79aff2dc4a644296348b76248/0E9240F1-46F8-4265-8CD8-A95E79BCC131.jpg"
                        #       }
                        #     }
                        #   }
                        # },
                        average_rating: {type: :integer,example:0},
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
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  # config.swagger_format = :yaml
  config.swagger_format = :json
end
