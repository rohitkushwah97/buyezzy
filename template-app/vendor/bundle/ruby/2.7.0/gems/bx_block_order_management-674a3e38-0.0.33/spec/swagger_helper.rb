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
        title: "bx_block_order_management",
        version: "1.0.0",
        description: "OrderManagement block API"
      },
      servers: [
        {
          url: "http://localhost:3000"
        } 
      ],
      components: {
        schemas: {
          order_management_orders:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  coupon_message: {type: :string,nullable: true,example: "coupon applied"},
                  order: {
                    type: :object,
                    properties:{
                      data: {
                        type: :object,
                        properties: {
                          id: {type: :string,nullable: false, example: "1"},
                          type: {type: :string,nullable: false, example: "order"},
                          attributes: {
                            type: :object,
                            properties: {
                              id: {type: :integer, example: 1},
                              order_number: {type: :string, example: "ORD001"},
                              amount: {type: :integer, nullable: false, example: 10},
                              created_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                              updated_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                              account_id: {type: :integer, example: 1},
                              coupon_code_id: {type: :integer,nullable:true, example: 1},
                              delivery_address_id: {type: :integer,nullable: true,example: 1},
                              sub_total: {type: :string, format: :decimal, example: "10.00"},
                              total: {type: :string, format: :decimal, example: "20.00"},
                              status: {type: :string, example: "in_cart"},
                              applied_discount: {type: :string, format: :decimal, example: "20.00"},
                              cancellation_reason: {type: :string,nullable: true, example: "Size is not proper"},
                              order_date: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              is_gift: {type: :boolean, example: false},
                              placed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              confirmed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              in_transit_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              delivered_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              cancelled_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              refunded_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              source: {type: :string,nullable: true, example: "test"},
                              shipment_id: {type: :string,nullable: true, example: "TEST0012"},
                              delivery_charges: {type: :string,nullable: true, example: "10"},
                              tracking_url: {type: :string,nullable: true, example: "http://test.com"},
                              schedule_time: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              payment_failed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              returned_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              tax_charges: {type: :string,nullable: true, format: :decimal, example: "2.00"},
                              deliver_by: {type: :integer,nullable: true, example: 1},
                              tracking_number: {type: :string,nullable: true, example: "TRACK001"},
                              is_error: {type: :boolean, example: false},
                              delivery_error_message: {type: :string,nullable: true, example: "Delivery failed"},
                              payment_pending_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              order_status_id: {type: :integer, example: 1},
                              is_group: {type: :boolean, example: false},
                              is_availability_checked: {type: :boolean, example: false},
                              shipping_charge: {type: :string,nullable: true, format: :decimal, example: 1.00},
                              shipping_discount: {type: :string,nullable: true, format: :decimal, example: 0.00},
                              shipping_net_amt: {type: :string,nullable: true, format: :decimal, example: 12.00},
                              shipping_total: {type: :string,nullable: true, format: :decimal, example: 13.00},
                              total_tax: {type: :number, format: :float, example: 2.05},
                              delivery_address: {
                                type: :array,
                                items: {
                                  type: :object,
                                  properties: {
                                    name: {type: :string,nullable: true, example: "test"},
                                    flat_no: {type: :string,nullable: true, example: "test"},
                                    address: {type: :string,nullable: true, example: "test"},
                                    zip_code: {type: :string,nullable: true, example: "test"},
                                    phone_number: {type: :string,nullable: true, example: "test"}
                                  }
                                }
                              },
                              razorpay_order_id: {type: :string,nullable: true, example: "TXN00123"},
                              charged: {type: :boolean,nullable: true, example: false},
                              invoiced: {type: :boolean,nullable: true, example: false},
                              invoice_id: {type: :string,nullable: true, example: "INV001"},
                              custom_label: {type: :string,nullable: true, example: "Handle care"},
                              order_items: {
                                type: :array,
                                items: {
                                  type: :object,
                                  properties: {
                                    id: {type: :string, example: "1"},
                                    type: {type: :string, example: "order_item"},
                                    attributes: {
                                      type: :object,
                                      properties: {
                                        id: {type: :integer, example: 1},
                                        order_management_order_id: {type: :integer, example: 1},
                                        quantity: {type: :integer, example: 1},
                                        unit_price: {type: :string, format: :decimal, example: "9.0"},
                                        total_price: {type: :string, format: :decimal, example: "9.0"},
                                        old_unit_price: {type: :string,nullable: true, format: :decimal, example: 9.0},
                                        status: {type: :string, example: "in_cart"},
                                        catalogue_id: {type: :integer, example: 1},
                                        catalogue_variant_id: {type: :integer, example: 1},
                                        order_status_id: {type: :integer, example: 1},
                                        placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        manage_placed_status: {type: :boolean, example: false},
                                        manage_cancelled_status: {type: :boolean, example: false},
                                        created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                        updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                        order_statuses: {
                                          type: :object,
                                          properties: {
                                            order_number: {type: :string, example: "OD00000004"},
                                            placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"}
                                          }
                                        },
                                        catalogue: {
                                          type: :object,
                                          properties: {
                                            id: {type: :string, example: "1"},
                                            type: {type: :string, example: "catalogue"},
                                            attributes: {
                                              type: :object,
                                              properties: {
                                                category: {
                                                  type: :object,
                                                  properties: {
                                                    id: {type: :integer, example: 1},
                                                    name: {type: :string, example: "abc"},
                                                    admin_user_id: {type: :integer,nullable:true, example: 1},
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
                                                    rank: {type: :integer,nullable:true, example: 1},
                                                    created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    updated_at: {type: :string,nullable:true, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    identifier: {type: :string,nullable:true, example: "abc"}
                                                  }
                                                },
                                                sub_category: {
                                                  type: :object,
                                                  properties: {
                                                    id: {type: :integer, example: 1},
                                                    name: {type: :string, example: "abc"},
                                                    created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    parent_id: {type: :integer,nullable:true, example: 1},
                                                    rank: {type: :integer,nullable:true, example: 1}
                                                  }
                                                },
                                                brand: {
                                                  type: :object,
                                                  properties: {
                                                    id: {type: :integer, example: 1},
                                                    name: {type: :string, example: "abc"},
                                                    created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    currency: {type: :integer,nullable:true, example: 1}
                                                  }
                                                },
                                                tags: {
                                                  type: :array,
                                                  items: {
                                                    type: :object,
                                                    properties: {
                                                      id: {type: :integer, example: 1},
                                                      name: {type: :string, example: "abc"},
                                                      created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                      updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                                    }
                                                  }
                                                },
                                                reviews: {
                                                  type: :array,
                                                  items: {
                                                    type: :object,
                                                    properties: {
                                                      id: {type: :integer, example: 1},
                                                      catalogue_id: {type: :integer, example: 1},
                                                      rating: {type: :integer, example: 1},
                                                      comment: {type: :string, example: "test"},
                                                      created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                      updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                                    }
                                                  }
                                                },
                                                name: {type: :string, example: "abc"},
                                                sku: {type: :string, example: "abc"},
                                                description: {type: :string, example: "testdec"},
                                                manufacture_date: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                length: {type: :number, format: :float, example: 5.3},
                                                breadth: {type: :number, format: :float, example: 5.3},
                                                height: {type: :number, format: :float, example: 5.3},
                                                stock_qty: {type: :integer, example: 1},
                                                availability: {type: :string, example: "1"},
                                                weight: {type: :string, format: :decimal, example: "20.00"},
                                                price: {type: :number, format: :float, example: 20.05},
                                                recommended: {type: :boolean, example: true},
                                                on_sale: {type: :boolean, example: true},
                                                sale_price: {type: :string, format: :decimal, example: "15.00"},
                                                discount: {type: :string, format: :decimal, example: "5.00"},

                                                average_rating: {type: :integer, example: 0},
                                                catalogue_varinats: {
                                                  type: :array,
                                                  items: {
                                                    type: :object,
                                                    properties: {
                                                      id: {type: :integer, example: 1},
                                                      type: {type: :string, example: "catalogue_varinat"},
                                                      attributes: {
                                                        type: :object,
                                                        properties: {
                                                          id: {type: :integer, example: 1},
                                                          catalogue_id: {type: :integer, example: 1},
                                                          catalogue_variant_color_id: {type: :integer, example: 1},
                                                          catalogue_variant_size_id: {type: :integer, example: 1},
                                                          price: {type: :number, format: :decimal, example: 20.00},
                                                          stock_qty: {type: :integer, example: 1},
                                                          on_sale: {type: :boolean, example: true},
                                                          sale_price: {type: :number, format: :decimal, example: 15.00},
                                                          discount_price: {type: :number, format: :decimal, example: 5.00},
                                                          length: {type: :number, format: :float, example: 5.3},
                                                          breadth: {type: :number, format: :float, example: 5.3},
                                                          height: {type: :number, format: :float, example: 5.3},
                                                          created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                          updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                          images: {type: :string, example: "test"}
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
                              account: {
                                type: :object,
                                properties: {
                                  id: {type: :string, example: "1"},
                                  type: {type: :string, example: "account"},
                                  attributes: {
                                    type: :object,
                                    properties: {
                                      id: {type: :integer, example: 1},
                                      activated: {type: :boolean, example: false},
                                      country_code: {type: :string,nullable:true, example: "IND"},
                                      email: {type: :string, example: "test1@test.com"},
                                      first_name: {type: :string, example: "first"},
                                      full_phone_number: {type: :string, example: "+91088767564"},
                                      last_name: {type: :string, example: "last"},
                                      phone_number: {type: :string, example: "123456789"},
                                      type: {type: :string, example: "EmailAccount"},
                                      created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                                      device_id: {type: :string, example: "drt567yh"},
                                      unique_auth_id: {type: :string, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"}

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
          create_delivery_address:{
            type: :object,
            properties: {
              delivery_address: {
                type: :object,
                properties: {
                  id: {type: :integer,example: 2},
                  account_id:{type: :integer,example: 1},
                  address: {type: :string,example:"add"},
                  name: {type: :string,example:"name"},
                  flat_no: {type: :string,example:"abcd"},
                  zip_code: {type: :string,example: "aa"},
                  phone_number: {type: :string,example: "9876543211"},
                  deleted_at: {type: :string,nullable: true, example: ""},
                  latitude: {type: :number,example: 96543211},
                  longitude: {type: :number,example: 98543211},
                  residential: {type: :boolean,example:true},
                  city: {type: :string,example: "city"},
                  state_code: {type: :string,example: "12"},
                  country_code: {type: :string,example: "32"},
                  state: {type: :string,example: "state"},
                  country: {type: :string,example: "country"},
                  address_line_2: {type: :string,example: "state"},
                  address_type: {type: :string,example: "state"},
                  address_for: {type: :string,example: "shipping"},
                  is_default: {type: :boolean,example: true},
                  landmark: {type: :string,example: "shipping"},
                  created_at: {type: :string,example: "2023-03-16T05:57:43.581Z"},
                  updated_at: {type: :string, example: "2023-03-16T05:57:43.581Z"}
                }
              }
            }
          },
          order:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable: false, example: "1"},
                  type: {type: :string,nullable: false, example: "order"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer, example: 1},
                      order_number: {type: :string, example: "ORD001"},
                      amount: {type: :integer, nullable: false, example: 10},
                      created_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                      updated_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                      account_id: {type: :integer, example: 1},
                      coupon_code_id: {type: :integer,nullable:true, example: 1},
                      delivery_address_id: {type: :integer,nullable: true,example: 1},
                      sub_total: {type: :string, format: :decimal, example: "10.00"},
                      total: {type: :string, format: :decimal, example: "20.00"},
                      status: {type: :string, example: "in_cart"},
                      applied_discount: {type: :string, format: :decimal, example: "20.00"},
                      cancellation_reason: {type: :string,nullable: true, example: "Size is not proper"},
                      order_date: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      is_gift: {type: :boolean, example: false},
                      placed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      confirmed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      in_transit_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      delivered_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      cancelled_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      refunded_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      source: {type: :string,nullable: true, example: "test"},
                      shipment_id: {type: :string,nullable: true, example: "TEST0012"},
                      delivery_charges: {type: :string,nullable: true, example: "10"},
                      tracking_url: {type: :string,nullable: true, example: "http://test.com"},
                      schedule_time: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      payment_failed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      returned_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      tax_charges: {type: :string,nullable: true, format: :decimal, example: "2.00"},
                      deliver_by: {type: :integer,nullable: true, example: 1},
                      tracking_number: {type: :string,nullable: true, example: "TRACK001"},
                      is_error: {type: :boolean, example: false},
                      delivery_error_message: {type: :string,nullable: true, example: "Delivery failed"},
                      payment_pending_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                      order_status_id: {type: :integer, example: 1},
                      is_group: {type: :boolean, example: false},
                      is_availability_checked: {type: :boolean, example: false},
                      shipping_charge: {type: :string,nullable: true, format: :decimal, example: 1.00},
                      shipping_discount: {type: :string,nullable: true, format: :decimal, example: 0.00},
                      shipping_net_amt: {type: :string,nullable: true, format: :decimal, example: 12.00},
                      shipping_total: {type: :string,nullable: true, format: :decimal, example: 13.00},
                      total_tax: {type: :number, format: :float, example: 2.05},
                      delivery_address: {
                        type: :array,
                        items: {
                          type: :object,
                          properties: {
                            name: {type: :string,nullable: true, example: "test"},
                            flat_no: {type: :string,nullable: true, example: "test"},
                            address: {type: :string,nullable: true, example: "test"},
                            zip_code: {type: :string,nullable: true, example: "test"},
                            phone_number: {type: :string,nullable: true, example: "test"}
                          }
                        }
                      },
                      razorpay_order_id: {type: :string,nullable: true, example: "TXN00123"},
                      charged: {type: :boolean,nullable: true, example: false},
                      invoiced: {type: :boolean,nullable: true, example: false},
                      invoice_id: {type: :string,nullable: true, example: "INV001"},
                      custom_label: {type: :string,nullable: true, example: "Handle care"},
                      order_items: {
                        type: :array,
                        items: {
                          type: :object,
                          properties: {
                            id: {type: :string, example: "1"},
                            type: {type: :string, example: "order_item"},
                            attributes: {
                              type: :object,
                              properties: {
                                id: {type: :integer, example: 1},
                                order_management_order_id: {type: :integer, example: 1},
                                quantity: {type: :integer, example: 1},
                                unit_price: {type: :string, format: :decimal, example: "9.0"},
                                total_price: {type: :string, format: :decimal, example: "9.0"},
                                old_unit_price: {type: :string,nullable: true, format: :decimal, example: 9.0},
                                status: {type: :string, example: "in_cart"},
                                catalogue_id: {type: :integer, example: 1},
                                catalogue_variant_id: {type: :integer, example: 1},
                                order_status_id: {type: :integer,nullable:true, example: 1},
                                placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                manage_placed_status: {type: :boolean, example: false},
                                manage_cancelled_status: {type: :boolean, example: false},
                                created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                order_statuses: {
                                  type: :object,
                                  properties: {
                                    order_number: {type: :string, example: "OD00000004"},
                                    placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                    confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                    in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                    delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                    cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                    refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"}
                                  }
                                },
                                catalogue: {
                                  type: :object,
                                  properties: {
                                    id: {type: :string, example: "1"},
                                    type: {type: :string, example: "catalogue"},
                                    attributes: {
                                      type: :object,
                                      properties: {
                                        category: {
                                          type: :object,
                                          properties: {
                                            id: {type: :integer, example: 1},
                                            name: {type: :string, example: "abc"},
                                            admin_user_id: {type: :integer,nullable:true, example: 1},
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
                                            rank: {type: :integer,nullable:true, example: 1},
                                            created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                            updated_at: {type: :string,nullable:true, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                            identifier: {type: :string,nullable:true, example: "abc"}
                                          }
                                        },
                                        sub_category: {
                                          type: :object,
                                          properties: {
                                            id: {type: :integer, example: 1},
                                            name: {type: :string, example: "abc"},
                                            created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                            updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                            parent_id: {type: :integer,nullable:true, example: 1},
                                            rank: {type: :integer,nullable:true, example: 1}
                                          }
                                        },
                                        brand: {
                                          type: :object,
                                          properties: {
                                            id: {type: :integer, example: 1},
                                            name: {type: :string, example: "abc"},
                                            created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                            updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                            currency: {type: :integer,nullable:true, example: 1}
                                          }
                                        },
                                        tags: {
                                          type: :array,
                                          items: {
                                            type: :object,
                                            properties: {
                                              id: {type: :integer, example: 1},
                                              name: {type: :string, example: "abc"},
                                              created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                            }
                                          }
                                        },
                                        reviews: {
                                          type: :array,
                                          items: {
                                            type: :object,
                                            properties: {
                                              id: {type: :integer, example: 1},
                                              catalogue_id: {type: :integer, example: 1},
                                              rating: {type: :integer, example: 1},
                                              comment: {type: :string, example: "test"},
                                              created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                            }
                                          }
                                        },
                                        name: {type: :string, example: "abc"},
                                        sku: {type: :string, example: "abc"},
                                        description: {type: :string, example: "testdec"},
                                        manufacture_date: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                        length: {type: :number, format: :float, example: 5.3},
                                        breadth: {type: :number, format: :float, example: 5.3},
                                        height: {type: :number, format: :float, example: 5.3},
                                        stock_qty: {type: :integer, example: 1},
                                        availability: {type: :string, example: "1"},
                                        weight: {type: :string, format: :decimal, example: "20.00"},
                                        price: {type: :number, format: :float, example: 20.05},
                                        recommended: {type: :boolean, example: true},
                                        on_sale: {type: :boolean, example: true},
                                        sale_price: {type: :string, format: :decimal, example: "15.00"},
                                        discount: {type: :string, format: :decimal, example: "5.00"},

                                        average_rating: {type: :integer, example: 0},
                                        catalogue_varinats: {
                                          type: :array,
                                          items: {
                                            type: :object,
                                            properties: {
                                              id: {type: :integer, example: 1},
                                              type: {type: :string, example: "catalogue_varinat"},
                                              attributes: {
                                                type: :object,
                                                properties: {
                                                  id: {type: :integer, example: 1},
                                                  catalogue_id: {type: :integer, example: 1},
                                                  catalogue_variant_color_id: {type: :integer, example: 1},
                                                  catalogue_variant_size_id: {type: :integer, example: 1},
                                                  price: {type: :number, format: :decimal, example: 20.00},
                                                  stock_qty: {type: :integer, example: 1},
                                                  on_sale: {type: :boolean, example: true},
                                                  sale_price: {type: :number, format: :decimal, example: 15.00},
                                                  discount_price: {type: :number, format: :decimal, example: 5.00},
                                                  length: {type: :number, format: :float, example: 5.3},
                                                  breadth: {type: :number, format: :float, example: 5.3},
                                                  height: {type: :number, format: :float, example: 5.3},
                                                  created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                  updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                  images: {type: :string, example: "test"}
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
                      account: {
                        type: :object,
                        properties: {
                          id: {type: :string, example: "1"},
                          type: {type: :string, example: "account"},
                          attributes: {
                            type: :object,
                            properties: {
                              id: {type: :integer, example: 1},
                              activated: {type: :boolean, example: false},
                              country_code: {type: :string,nullable:true, example: "IND"},
                              email: {type: :string, example: "test1@test.com"},
                              first_name: {type: :string, example: "first"},
                              full_phone_number: {type: :string, example: "+91088767564"},
                              last_name: {type: :string, example: "last"},
                              phone_number: {type: :string, example: "123456789"},
                              type: {type: :string, example: "EmailAccount"},
                              created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                              device_id: {type: :string, example: "drt567yh"},
                              unique_auth_id: {type: :string, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"}

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
          list_of_orders:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "order"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer, example: 1},
                        order_number: {type: :string, example: "ORD001"},
                        amount: {type: :integer, nullable: false, example: 10},
                        created_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                        updated_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                        account_id: {type: :integer, example: 1},
                        coupon_code_id: {type: :integer,nullable:true, example: 1},
                        delivery_address_id: {type: :integer,nullable: true,example: 1},
                        sub_total: {type: :string, format: :decimal, example: "10.00"},
                        total: {type: :string, format: :decimal, example: "20.00"},
                        status: {type: :string, example: "in_cart"},
                        applied_discount: {type: :string, format: :decimal, example: "20.00"},
                        cancellation_reason: {type: :string,nullable: true, example: "Size is not proper"},
                        order_date: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        is_gift: {type: :boolean, example: false},
                        placed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        confirmed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        in_transit_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        delivered_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        cancelled_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        refunded_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        source: {type: :string,nullable: true, example: "test"},
                        shipment_id: {type: :string,nullable: true, example: "TEST0012"},
                        delivery_charges: {type: :string,nullable: true, example: "10"},
                        tracking_url: {type: :string,nullable: true, example: "http://test.com"},
                        schedule_time: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        payment_failed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        returned_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        tax_charges: {type: :string,nullable: true, format: :decimal, example: "2.00"},
                        deliver_by: {type: :integer,nullable: true, example: 1},
                        tracking_number: {type: :string,nullable: true, example: "TRACK001"},
                        is_error: {type: :boolean, example: false},
                        delivery_error_message: {type: :string,nullable: true, example: "Delivery failed"},
                        payment_pending_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                        order_status_id: {type: :integer, example: 1},
                        is_group: {type: :boolean, example: false},
                        is_availability_checked: {type: :boolean, example: false},
                        shipping_charge: {type: :string,nullable: true, format: :decimal, example: 1.00},
                        shipping_discount: {type: :string,nullable: true, format: :decimal, example: 0.00},
                        shipping_net_amt: {type: :string,nullable: true, format: :decimal, example: 12.00},
                        shipping_total: {type: :string,nullable: true, format: :decimal, example: 13.00},
                        total_tax: {type: :number, format: :float, example: 2.05},
                        delivery_address: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              name: {type: :string,nullable: true, example: "test"},
                              flat_no: {type: :string,nullable: true, example: "test"},
                              address: {type: :string,nullable: true, example: "test"},
                              zip_code: {type: :string,nullable: true, example: "test"},
                              phone_number: {type: :string,nullable: true, example: "test"}
                            }
                          }
                        },
                        razorpay_order_id: {type: :string,nullable: true, example: "TXN00123"},
                        charged: {type: :boolean,nullable: true, example: false},
                        invoiced: {type: :boolean,nullable: true, example: false},
                        invoice_id: {type: :string,nullable: true, example: "INV001"},
                        custom_label: {type: :string,nullable: true, example: "Handle care"},
                        order_items: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              id: {type: :string, example: "1"},
                              type: {type: :string, example: "order_item"},
                              attributes: {
                                type: :object,
                                properties: {
                                  id: {type: :integer, example: 1},
                                  order_management_order_id: {type: :integer, example: 1},
                                  quantity: {type: :integer, example: 1},
                                  unit_price: {type: :string, format: :decimal, example: "9.0"},
                                  total_price: {type: :string, format: :decimal, example: "9.0"},
                                  old_unit_price: {type: :string,nullable: true, format: :decimal, example: 9.0},
                                  status: {type: :string, example: "in_cart"},
                                  catalogue_id: {type: :integer, example: 1},
                                  catalogue_variant_id: {type: :integer, example: 1},
                                  order_status_id: {type: :integer, example: 1},
                                  placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                  confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                  in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                  delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                  cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                  refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                  manage_placed_status: {type: :boolean, example: false},
                                  manage_cancelled_status: {type: :boolean, example: false},
                                  created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                  updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                  order_statuses: {
                                    type: :object,
                                    properties: {
                                      order_number: {type: :string, example: "OD00000004"},
                                      placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                      confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                      in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                      delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                      cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                      refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"}
                                    }
                                  },
                                  catalogue: {
                                    type: :object,
                                    properties: {
                                      id: {type: :string, example: "1"},
                                      type: {type: :string, example: "catalogue"},
                                      attributes: {
                                        type: :object,
                                        properties: {
                                          category: {
                                            type: :object,
                                            properties: {
                                              id: {type: :integer, example: 1},
                                              name: {type: :string, example: "abc"},
                                              admin_user_id: {type: :integer,nullable:true, example: 1},
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
                                              rank: {type: :integer,nullable:true, example: 1},
                                              created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              updated_at: {type: :string,nullable:true, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              identifier: {type: :string,nullable:true, example: "abc"}
                                            }
                                          },
                                          sub_category: {
                                            type: :object,
                                            properties: {
                                              id: {type: :integer, example: 1},
                                              name: {type: :string, example: "abc"},
                                              created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              parent_id: {type: :integer,nullable:true, example: 1},
                                              rank: {type: :integer,nullable:true, example: 1}
                                            }
                                          },
                                          brand: {
                                            type: :object,
                                            properties: {
                                              id: {type: :integer, example: 1},
                                              name: {type: :string, example: "abc"},
                                              created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                              currency: {type: :integer,nullable:true, example: 1}
                                            }
                                          },
                                          tags: {
                                            type: :array,
                                            items: {
                                              type: :object,
                                              properties: {
                                                id: {type: :integer, example: 1},
                                                name: {type: :string, example: "abc"},
                                                created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                              }
                                            }
                                          },
                                          reviews: {
                                            type: :array,
                                            items: {
                                              type: :object,
                                              properties: {
                                                id: {type: :integer, example: 1},
                                                catalogue_id: {type: :integer, example: 1},
                                                rating: {type: :integer, example: 1},
                                                comment: {type: :string, example: "test"},
                                                created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                              }
                                            }
                                          },
                                          name: {type: :string, example: "abc"},
                                          sku: {type: :string, example: "abc"},
                                          description: {type: :string, example: "testdec"},
                                          manufacture_date: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                          length: {type: :number, format: :float, example: 5.3},
                                          breadth: {type: :number, format: :float, example: 5.3},
                                          height: {type: :number, format: :float, example: 5.3},
                                          stock_qty: {type: :integer, example: 1},
                                          availability: {type: :string, example: "1"},
                                          weight: {type: :string, format: :decimal, example: "20.00"},
                                          price: {type: :number, format: :float, example: 20.05},
                                          recommended: {type: :boolean, example: true},
                                          on_sale: {type: :boolean, example: true},
                                          sale_price: {type: :string, format: :decimal, example: "15.00"},
                                          discount: {type: :string, format: :decimal, example: "5.00"},

                                          average_rating: {type: :integer, example: 0},
                                          catalogue_varinats: {
                                            type: :array,
                                            items: {
                                              type: :object,
                                              properties: {
                                                id: {type: :integer, example: 1},
                                                type: {type: :string, example: "catalogue_varinat"},
                                                attributes: {
                                                  type: :object,
                                                  properties: {
                                                    id: {type: :integer, example: 1},
                                                    catalogue_id: {type: :integer, example: 1},
                                                    catalogue_variant_color_id: {type: :integer, example: 1},
                                                    catalogue_variant_size_id: {type: :integer, example: 1},
                                                    price: {type: :number, format: :decimal, example: 20.00},
                                                    stock_qty: {type: :integer, example: 1},
                                                    on_sale: {type: :boolean, example: true},
                                                    sale_price: {type: :number, format: :decimal, example: 15.00},
                                                    discount_price: {type: :number, format: :decimal, example: 5.00},
                                                    length: {type: :number, format: :float, example: 5.3},
                                                    breadth: {type: :number, format: :float, example: 5.3},
                                                    height: {type: :number, format: :float, example: 5.3},
                                                    created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    images: {type: :string, example: "test"}
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
                        account: {
                          type: :object,
                          properties: {
                            id: {type: :string,nullable:false, example: "1"},
                            type: {type: :string,nullable:false, example: "account"},
                            attributes: {
                              type: :object,
                              properties: {
                                id: {type: :integer, example: 1},
                                activated: {type: :boolean, example: false},
                                country_code: {type: :string,nullable:true, example: "IND"},
                                email: {type: :string, example: "test1@test.com"},
                                first_name: {type: :string, example: "first"},
                                full_phone_number: {type: :string, example: "+91088767564"},
                                last_name: {type: :string, example: "last"},
                                phone_number: {type: :string, example: "123456789"},
                                type: {type: :string, example: "EmailAccount"},
                                created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                                device_id: {type: :string, example: "drt567yh"},
                                unique_auth_id: {type: :string, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"}
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
          addresses: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string,nullable: false, example: "1"},
                  type: {type: :string, nullable: false, example: "addresses"},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer, example: 1},
                      name: {type: :string, example: "Abc"},
                      flat_no: {type: :string, example: "B123"},
                      address: {type: :string, example: "Address"},
                      address_type: {type: :string, example: "home"},
                      address_line_2: {type: :string, example: "Street"},
                      zip_code: {type: :string, example: "101010"},
                      phone_number: {type: :string, example: "9876543210"},
                      address_for: {type: :string, example: "shipping"},
                      city: {type: :string, example: "city"},
                      state: {type: :string, example: "state"},
                      country: {type: :string, example: "country"},
                      landmark: {type: :string, example: "landmark"},
                      is_default: {type: :boolean, example: false},
                      longitude: {type: :number, format: :float, example: 12.23},
                      latitude: {type: :number, format: :float, example: 23.34},
                      created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                      updated_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                      account: {
                        type: :object,
                        properties: {
                          id: {type: :integer, example: 1},
                          activated: {type: :boolean, example: false},
                          country_code: {type: :number, example: +1},
                          email: {type: :string, example: "test1@test.com"},
                          first_name: {type: :string, example: "first"},
                          full_phone_number: {type: :string, example: "+91088767564"},
                          last_name: {type: :string, example: "last"},
                          phone_number: {type: :number, example: 123456789},
                          created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                          updated_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                          device_id: {type: :string, example: "EmailAccount"},
                          unique_auth_id: {type: :string, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"},
                          password_digest: {type: :string, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"},
                          user_name: {type: :string, example: "first"},
                          platform: {type: :string, example: "mobile"},
                          user_type: {type: :string, example: "guest"},
                          app_language_id: {type: :integer, example: 1},
                          last_visit_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                          is_blacklisted: {type: :boolean, example: false},
                          suspend_until: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                          status: {type: :string, example: "1"},
                          stripe_id: {type: :string, example: "test123"},
                          stripe_subscription_id: {type: :string, example: "test123"},
                          stripe_subscription_date: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"}
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          address_list:{
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: {type: :string,nullable: false, example: "1"},
                    type: {type: :string, nullable: false, example: "addresses"},
                    attributes: {
                      type: :object,
                      properties: {
                        id: {type: :integer, example: 1},
                        name: {type: :string, example: "Abc"},
                        flat_no: {type: :string, example: "B123"},
                        address: {type: :string, example: "Address"},
                        address_type: {type: :string, example: "home"},
                        address_line_2: {type: :string, example: "Street"},
                        zip_code: {type: :string, example: "101010"},
                        phone_number: {type: :string, example: "9876543210"},
                        address_for: {type: :string, example: "shipping"},
                        city: {type: :string, example: "city"},
                        state: {type: :string, example: "state"},
                        country: {type: :string, example: "country"},
                        landmark: {type: :string, example: "landmark"},
                        is_default: {type: :boolean, example: false},
                        longitude: {type: :number, format: :float, example: 12.23},
                        latitude: {type: :number, format: :float, example: 23.34},
                        created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                        updated_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                      }
                    }
                  }
                }
              }
            }
          },
          apply_coupon_code:{
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  coupon: {
                    type: :object,
                    properties: {
                      data: {
                        type: :object,
                        properties: {
                          id: {type: :string,nullable: false, example: "1"},
                          type: {type: :string,nullable: false, example: "order"},
                          attributes: {
                            type: :object,
                            properties: {
                              id: {type: :integer, example: 1},
                              order_number: {type: :string, example: "ORD001"},
                              amount: {type: :integer, nullable: false, example: 10},
                              created_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                              updated_at: {type: :string, format: :datetime, nullable: true, example: "2022-12-17 10:29:55"},
                              account_id: {type: :integer, example: 1},
                              coupon_code_id: {type: :integer,nullable:true, example: 1},
                              delivery_address_id: {type: :integer,nullable: true,example: 1},
                              sub_total: {type: :string, format: :decimal, example: "10.00"},
                              total: {type: :string, format: :decimal, example: "20.00"},
                              status: {type: :string, example: "in_cart"},
                              applied_discount: {type: :string, format: :decimal, example: "20.00"},
                              cancellation_reason: {type: :string,nullable: true, example: "Size is not proper"},
                              order_date: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              is_gift: {type: :boolean, example: false},
                              placed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              confirmed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              in_transit_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              delivered_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              cancelled_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              refunded_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              source: {type: :string,nullable: true, example: "test"},
                              shipment_id: {type: :string,nullable: true, example: "TEST0012"},
                              delivery_charges: {type: :string,nullable: true, example: "10"},
                              tracking_url: {type: :string,nullable: true, example: "http://test.com"},
                              schedule_time: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              payment_failed_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              returned_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              tax_charges: {type: :string,nullable: true, format: :decimal, example: "2.00"},
                              deliver_by: {type: :integer,nullable: true, example: 1},
                              tracking_number: {type: :string,nullable: true, example: "TRACK001"},
                              is_error: {type: :boolean, example: false},
                              delivery_error_message: {type: :string,nullable: true, example: "Delivery failed"},
                              payment_pending_at: {type: :string,nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                              order_status_id: {type: :integer, example: 1},
                              is_group: {type: :boolean, example: false},
                              is_availability_checked: {type: :boolean, example: false},
                              shipping_charge: {type: :string,nullable: true, format: :decimal, example: 1.00},
                              shipping_discount: {type: :string,nullable: true, format: :decimal, example: 0.00},
                              shipping_net_amt: {type: :string,nullable: true, format: :decimal, example: 12.00},
                              shipping_total: {type: :string,nullable: true, format: :decimal, example: 13.00},
                              total_tax: {type: :number, format: :float, example: 2.05},
                              delivery_address: {
                                type: :array,
                                items: {
                                  type: :object,
                                  properties: {
                                    name: {type: :string,nullable: true, example: "test"},
                                    flat_no: {type: :string,nullable: true, example: "test"},
                                    address: {type: :string,nullable: true, example: "test"},
                                    zip_code: {type: :string,nullable: true, example: "test"},
                                    phone_number: {type: :string,nullable: true, example: "test"}
                                  }
                                }
                              },
                              razorpay_order_id: {type: :string,nullable: true, example: "TXN00123"},
                              charged: {type: :boolean,nullable: true, example: false},
                              invoiced: {type: :boolean,nullable: true, example: false},
                              invoice_id: {type: :string,nullable: true, example: "INV001"},
                              custom_label: {type: :string,nullable: true, example: "Handle care"},
                              order_items: {
                                type: :array,
                                items: {
                                  type: :object,
                                  properties: {
                                    id: {type: :string, example: "1"},
                                    type: {type: :string, example: "order_item"},
                                    attributes: {
                                      type: :object,
                                      properties: {
                                        id: {type: :integer, example: 1},
                                        order_management_order_id: {type: :integer, example: 1},
                                        quantity: {type: :integer, example: 1},
                                        unit_price: {type: :string, format: :decimal, example: "9.0"},
                                        total_price: {type: :string, format: :decimal, example: "9.0"},
                                        old_unit_price: {type: :string,nullable: true, format: :decimal, example: 9.0},
                                        status: {type: :string, example: "in_cart"},
                                        catalogue_id: {type: :integer, example: 1},
                                        catalogue_variant_id: {type: :integer, example: 1},
                                        order_status_id: {type: :integer, example: 1},
                                        placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                        manage_placed_status: {type: :boolean, example: false},
                                        manage_cancelled_status: {type: :boolean, example: false},
                                        created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                        updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.426Z"},
                                        order_statuses: {
                                          type: :object,
                                          properties: {
                                            order_number: {type: :string, example: "OD00000004"},
                                            placed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            confirmed_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            in_transit_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            delivered_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            cancelled_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"},
                                            refunded_at: {type: :string, nullable: true, format: :datetime, example: "2022-12-17 10:29:55"}
                                          }
                                        },
                                        catalogue: {
                                          type: :object,
                                          properties: {
                                            id: {type: :string, example: "1"},
                                            type: {type: :string, example: "catalogue"},
                                            attributes: {
                                              type: :object,
                                              properties: {
                                                category: {
                                                  type: :object,
                                                  properties: {
                                                    id: {type: :integer, example: 1},
                                                    name: {type: :string, example: "abc"},
                                                    admin_user_id: {type: :integer,nullable:true, example: 1},
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
                                                    rank: {type: :integer,nullable:true, example: 1},
                                                    created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    updated_at: {type: :string,nullable:true, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    identifier: {type: :string,nullable:true, example: "abc"}
                                                  }
                                                },
                                                sub_category: {
                                                  type: :object,
                                                  properties: {
                                                    id: {type: :integer, example: 1},
                                                    name: {type: :string, example: "abc"},
                                                    created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    parent_id: {type: :integer,nullable:true, example: 1},
                                                    rank: {type: :integer,nullable:true, example: 1}
                                                  }
                                                },
                                                brand: {
                                                  type: :object,
                                                  properties: {
                                                    id: {type: :integer, example: 1},
                                                    name: {type: :string, example: "abc"},
                                                    created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                    currency: {type: :integer,nullable:true, example: 1}
                                                  }
                                                },
                                                tags: {
                                                  type: :array,
                                                  items: {
                                                    type: :object,
                                                    properties: {
                                                      id: {type: :integer, example: 1},
                                                      name: {type: :string, example: "abc"},
                                                      created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                      updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                                    }
                                                  }
                                                },
                                                reviews: {
                                                  type: :array,
                                                  items: {
                                                    type: :object,
                                                    properties: {
                                                      id: {type: :integer, example: 1},
                                                      catalogue_id: {type: :integer, example: 1},
                                                      rating: {type: :integer, example: 1},
                                                      comment: {type: :string, example: "test"},
                                                      created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                      updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"}
                                                    }
                                                  }
                                                },
                                                name: {type: :string, example: "abc"},
                                                sku: {type: :string, example: "abc"},
                                                description: {type: :string, example: "testdec"},
                                                manufacture_date: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                length: {type: :number, format: :float, example: 5.3},
                                                breadth: {type: :number, format: :float, example: 5.3},
                                                height: {type: :number, format: :float, example: 5.3},
                                                stock_qty: {type: :integer, example: 1},
                                                availability: {type: :string, example: "1"},
                                                weight: {type: :string, format: :decimal, example: "20.00"},
                                                price: {type: :number, format: :float, example: 20.05},
                                                recommended: {type: :boolean, example: true},
                                                on_sale: {type: :boolean, example: true},
                                                sale_price: {type: :string, format: :decimal, example: "15.00"},
                                                discount: {type: :string, format: :decimal, example: "5.00"},

                                                average_rating: {type: :integer, example: 0},
                                                catalogue_varinats: {
                                                  type: :array,
                                                  items: {
                                                    type: :object,
                                                    properties: {
                                                      id: {type: :integer, example: 1},
                                                      type: {type: :string, example: "catalogue_varinat"},
                                                      attributes: {
                                                        type: :object,
                                                        properties: {
                                                          id: {type: :integer, example: 1},
                                                          catalogue_id: {type: :integer, example: 1},
                                                          catalogue_variant_color_id: {type: :integer, example: 1},
                                                          catalogue_variant_size_id: {type: :integer, example: 1},
                                                          price: {type: :number, format: :decimal, example: 20.00},
                                                          stock_qty: {type: :integer, example: 1},
                                                          on_sale: {type: :boolean, example: true},
                                                          sale_price: {type: :number, format: :decimal, example: 15.00},
                                                          discount_price: {type: :number, format: :decimal, example: 5.00},
                                                          length: {type: :number, format: :float, example: 5.3},
                                                          breadth: {type: :number, format: :float, example: 5.3},
                                                          height: {type: :number, format: :float, example: 5.3},
                                                          created_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                          updated_at: {type: :string, format: :datetime, example: "2023-01-27T11:47:30.388Z"},
                                                          images: {type: :string, example: "test"}
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
                              account: {
                                type: :object,
                                properties: {
                                  id: {type: :string, example: "1"},
                                  type: {type: :string, example: "account"},
                                  attributes: {
                                    type: :object,
                                    properties: {
                                      id: {type: :integer, example: 1},
                                      activated: {type: :boolean, example: false},
                                      country_code: {type: :string,nullable:true, example: "IND"},
                                      email: {type: :string, example: "test1@test.com"},
                                      first_name: {type: :string, example: "first"},
                                      full_phone_number: {type: :string, example: "+91088767564"},
                                      last_name: {type: :string, example: "last"},
                                      phone_number: {type: :string, example: "123456789"},
                                      type: {type: :string, example: "EmailAccount"},
                                      created_at: {type: :string, format: :datetime, example: "2023-01-30T06:32:31.563Z"},
                                      device_id: {type: :string, example: "drt567yh"},
                                      unique_auth_id: {type: :string, example: "Sh5sq9kjpZpGTUTgH9CkIwtt"}

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
                  message: {
                    type: :string,example:"Coupon applied to all items in the order with status in cart"
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
