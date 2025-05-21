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
        title: "bx_block_posts",
        version: "1.0.0",
        description: "Post block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        }
      ],
      components: {
        schemas: {
          room:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable: false, example: "1"},
                  type: {type: :string,nullable: false, example: "chat"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,nullable: false, example:"1"},
                      name: {type: :string,nullable: false, example: "test room"},
                      accounts_chats: {
                        type: :array,
                        items: {
                          type: :object,
                          properties: {
                            id: {type: :string,nullable: false, example: "1"},
                            type: {type: :string,nullable: false, example: "accounts_chats"},
                            attributes: {
                              type: :object,
                              properties: {
                                account_id: {type: :integer,nullable:false,example: 1 },
                                muted: {type: :boolean,example:false,nullable: true},
                                unread_count: {type: :integer,example:0}
                              },
                            }
                          },
                        }
                      },
                      messages: {
                        type: :array,
                        items: {
                          type: :object,
                        }
                      }
                    },
                  },
                  relationships: {
                    type: :object,
                    properties: {
                      accounts: {
                        type: :object,
                        properties: {
                          data: {
                            type: :array,
                            items: {
                              type: :object,
                              properties: {
                                id: { type: :string,nullable: false,example:1},
                                type: {type: :string,nullable:false,example: "account"}
                              },
                            }
                          }
                        },
                      }
                    },
                  }
                },
              }
            },
          },
          room_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items:{
                  type: :object,
                  properties: {
                    id: {type: :string,nullable: false, example: "1"},
                    type: {type: :string,nullable: false, example: "chat_only"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,nullable: false, example: 1},
                        name: {type: :string,nullable: false, example: "test room update"},
                      },
                    },
                    relationships: {
                      type: :object,
                      properties: {
                        accounts: {
                          type: :object,
                          properties: {
                            data: {
                              type: :array,
                              items:{
                                type: :object,
                                properties: {
                                  id: {type: :string,nullable: false, example: "1"},
                                  type: {type: :string,nullable: false, example: "account"},
                                },
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
          },
          mychat:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items:{
                  type: :object,
                  properties: {
                    id: {
                      type: :string,nullable: false,example: "1"
                    },
                    type: {
                      type: :string,nullable: false,example: "chat_my_chat"
                    },
                    attributes: {
                      type: :object,
                      properties: {
                        name: {
                          type: :string,example: "test room"
                        },
                        accounts_chats: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              id: {
                                type: :string,example: "2"
                              },
                              type: {
                                type: :string,example:"accounts_chats"
                              },
                              attributes: {
                                type: :object,
                                properties: {
                                  account_id: {
                                    type: :integer,example: 1
                                  },
                                  muted: {
                                    type: :boolean,example: true,nullable: true
                                  },
                                  unread_count: {
                                    type: :integer,example:0, nullable:true
                                  }
                                },
                              }
                            },
                          }
                        },
                        messages: {
                          type: :object,
                          properties: {
                            id: {
                              type: :string,example: "2"
                            },
                            type: {
                              type: :string,example:"chat_message"
                            },
                            attributes: {
                              type: :object,
                              properties: {
                                id: {
                                  type: :integer,example:1
                                },
                                message: {
                                  type: :string,example:"hello"
                                },
                                account_id: {
                                  type: :integer,example:1
                                },
                                chat_id: {
                                  type: :integer,example:2
                                },
                                created_at: {
                                  type: :string,example:"2023-03-29T11:35:56.647Z"
                                },
                                updated_at: {
                                  type: :string,example: "2023-03-29T11:36:56.647Z"
                                },
                                is_mark_read: {
                                  type: :boolean,example:true
                                },
                                attachments: {
                                  type: :array,nullable:true,
                                  items:{
                                    type: :object,
                                    properties: {
                                      id: {
                                        type: :integer,example: 1
                                      },
                                      url: {
                                        type: :string,example: "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--27b7771419dcf7491ca3cd068646af0ac621c777/Screenshot%20from%202023-03-07%2018-06-42.png"
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
          },
          hostory:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items:{
                  type: :object,
                  properties: {
                    id: { type: :string,nullable:false, example:1 },
                    type: {type: :string,nullable:false,example:"chat_history" },
                    attributes: {
                      type: :object,
                      properties: {
                        name: { type: :string,nullable:false,example: "test room" },
                        accounts_chats: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              id: { type: :string,nullable:false,example:"1" },
                              type: { type: :string,nullable:false,example:"accounts_chats"},
                              attributes: {
                                type: :object,
                                properties: {
                                  account_id: { type: :integer,nullable:false,example:1},
                                  muted: {  type: :boolean,nullable:true,example:true },
                                  unread_count: {type: :integer,example:0}
                                }
                              }
                            }
                          }
                        },
                        messages: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              id: { type: :string,example:"1" },
                              type: { type: :string,example:"chat_message"},
                              attributes: {
                                type: :object,
                                properties: {
                                  id: { type: :integer,example:1 },
                                  message: { type: :string ,example: "hello" },
                                  account_id: { type: :integer,example:1},
                                  chat_id: { type: :integer,example:2},
                                  created_at: {  type: :string ,example: "2023-03-29T11:35:56.647Z"},
                                  updated_at: { type: :string,example: "2023-03-29T11:35:56.647Z"},
                                  is_mark_read: { type: :boolean,example:false},
                                  attachments: {
                                    type: :array,nullable:true,
                                    items:{
                                      type: :object,
                                      properties: {
                                        id: {
                                          type: :integer,example: 1
                                        },
                                        url: {
                                          type: :string,example: "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--27b7771419dcf7491ca3cd068646af0ac621c777/Screenshot%20from%202023-03-07%2018-06-42.png"
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
          },
          search_msg:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable:false, example:1},
                    type: {  type: :string,nullable:false,example:"chat_message" },
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer,example:1 },
                        message: {type: :string,example: "hello"},
                        account_id: { type: :integer,example:1 },
                        chat_id: {type: :integer,example:2},
                        created_at: { type: :string ,example:"2023-03-29T11:35:56.647Z"},
                        updated_at: { type: :string,example:"2023-03-29T11:35:56.647Z"},
                        is_mark_read: { type: :boolean,example:true },
                        attachments: {
                          type: :array,nullable: true,
                          items: {
                            type: :object,
                            properties: {
                              id: { type: :integer,example:1},
                               url: {
                                type: :string,example: "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--27b7771419dcf7491ca3cd068646af0ac621c777/Screenshot%20from%202023-03-07%2018-06-42.png"
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
          },
          group_msg:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable:false,example:1 },
                    type: {type: :string,nullable:false,example: "chat"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: { type: :integer,nullable:false,example:1 },
                        name: {type: :string,nullable:false,example: "test room" },
                        accounts_chats: {
                          type: :array,
                          items:{
                            type: :object,
                            properties: {
                              id: {
                                type: :string,example:1
                              },
                              type: {
                                type: :string,example:"accounts_chats"
                              },
                              attributes: {
                                type: :object,
                                properties: {
                                  account_id: {
                                    type: :integer,example:1
                                  },
                                  muted: {
                                    type: :boolean,example:false
                                  },
                                  unread_count: {
                                    type: :integer,example:1
                                  }
                                },
                              }
                            },
                          }
                        },
                        messages: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              id: {
                                type: :string,example:"1",
                              },
                              type: {
                                type: :string,example:"chat_message",
                              },
                              attributes: {
                                type: :object,
                                properties: {
                                  id: {
                                    type: :integer,example:1
                                  },
                                  message: {
                                    type: :string,example:"hello"
                                  },
                                  account_id: {
                                    type: :integer,example:1
                                  },
                                  chat_id: {
                                    type: :integer,example:2
                                  },
                                  created_at: {
                                    type: :string,example:"2023-03-29T11:35:56.647Z"
                                  },
                                  updated_at: {
                                    type: :string,example:"2023-03-29T11:35:56.647Z"
                                  },
                                  is_mark_read: {
                                    type: :boolean,example:0
                                  },
                                  attachments: {
                                    type: :array,nullable:true,
                                    items:{
                                      type: :object,
                                      properties: {
                                        id: {
                                          type: :integer,example:1
                                        },
                                        url: {
                                          type: :string,example: "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--27b7771419dcf7491ca3cd068646af0ac621c777/Screenshot%20from%202023-03-07%2018-06-42.png"
                                        }
                                      },
                                    }
                                  }
                                },
                              }
                            },
                          }
                        }
                      },
                    },
                    relationships: {
                      type: :object,
                      properties: {
                        accounts: {
                          type: :object,
                          properties: {
                            data: {
                              type: :array,
                              items: {
                                type: :object,
                                properties: {
                                  id: {
                                    type: :string,example:"1"
                                  },
                                  type: {
                                    type: :string,example:"account"
                                  }
                                },
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
          },
          add_user:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable:false,example:"1" },
                    type: { type: :string,nullable:false,example:"chat_only" },
                    attributes: {
                      type: :object,
                      properties: {
                        id: { type: :integer,nullable:false,example:1 },
                        name: { type: :string,nullable:false,example:"test room update" }
                      },
                    },
                    relationships: {
                      type: :object,
                      properties: {
                        accounts: {
                          type: :object,
                          properties: {
                            data: {
                              type: :array,
                              items: {
                                type: :object,
                                properties: {
                                  id: { type: :string,example:"1"},
                                  type: { type: :string,example:"account"}
                                },
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
          },
          send_msg:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: { type: :string,nullable:false,example:"1"},
                  type: { type: :string,nullable:false, example:"chat_message"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer,example:1},
                      message: { type: :string,example:"hello"},
                      account_id: { type: :integer,example:1 },
                      chat_id: {type: :integer,example:1},
                      created_at: { type: :string,example:"2023-03-29T11:35:56.647Z"},
                      updated_at: {type: :string,example:"2023-03-29T11:35:56.647Z"},
                      is_mark_read: {type: :boolean,example:0},
                      attachments: {
                        type: :array,nullable:true,
                        items:{
                          type: :object,
                          properties: {
                            id: {
                              type: :integer,example: 1
                            },
                            url: {
                              type: :string,example: "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--27b7771419dcf7491ca3cd068646af0ac621c777/Screenshot%20from%202023-03-07%2018-06-42.png"
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
  # config.swagger_format = :yaml
  config.swagger_format = :json
end
