require 'swagger_helper'

RSpec.describe '/bx_block_fedex_integration', :jwt do
  let(:headers) { {:token => token} }

  let(:json)   { JSON response.body }
  let(:data)   { json['data'] }
  let(:token)  { jwt }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }

  let(:account) { create :email_account }
  let(:id)      { account.id }

  before :context do
    data = YAML.load_file(Rails.root.join('app/assets/files/shipments_attributes.yml'))
    @shipment_params = { data: { attributes: data } }
  end

  path '/fedex_integration/shipments' do
    post 'Create Shipments' do
      tags 'Fedex Integration'
      consumes "application/json"
      produces "application/json"
      parameter name: 'token', in: :header, type: :string, default: '{{bx_blocks_api_token}}'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  shipments_attributes: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        full_truck: { type: :boolean },
                        load_description: { type: :string },
                        cod_value_attributes: {
                          type: :object,
                          properties: {
                            amount: { type: :float },
                            currency: { type: :string }
                          }
                        },
                        shipment_value_attributes: {
                          type: :object,
                          properties: {
                            amount: { type: :float },
                            currency: { type: :string }
                          }
                        },
                        delivery_attributes: {
                          type: :object,
                          properties: {
                            address: { type: :string },
                            city: { type: :string },
                            country: { type: :string },
                            email: { type: :string },
                            name: { type: :string },
                            phone: { type: :string },
                            instructions: { type: :string },
                            arrival_window_attributes: {
                              type: :object,
                              properties: {
                                begin_at: { type: :date },
                                end_at: { type: :date }
                              }
                            },
                            coordinate_attributes: {
                              type: :object,
                              properties: {
                                latitude: { type: :string },
                                longitude: { type: :string }
                              }
                            }
                          }
                        },
                        pickup_attributes: {
                          type: :object,
                          properties: {
                            address: { type: :string },
                            city: { type: :string },
                            country: { type: :string },
                            email: { type: :string },
                            name: { type: :string },
                            phone: { type: :string },
                            instructions: { type: :string },
                            arrival_window_attributes: {
                              type: :object,
                              properties: {
                                begin_at: { type: :date },
                                end_at: { type: :date }
                              }
                            },
                            coordinate_attributes: {
                              type: :object,
                              properties: {
                                latitude: { type: :string },
                                longitude: { type: :string }
                              }
                            }
                          }
                        },
                        items_attributes: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              weight: { type: :string },
                              quantity: { type: :integer },
                              item_type: { type: :string },
                              dimension_attributes: {
                                type: :object,
                                properties: {
                                  height: { type: :integer },
                                  length: { type: :integer },
                                  width: { type: :integer },
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

      context 'success' do
        let(:params) {
            @shipment_params
          }

        response '201', :success do
          schema type: :object,
                  properties: {
                    waybill: { type: :string },
                    status: { type: :string },
                    id: { type: :integer },
                    trackingURL: { type: :string },
                    shippingLabelUrl: { type: :string }
                  }

          before do |example|
            VCR.use_cassette('fedex_shipment_create') do
              submit_request(example.metadata)
            end
          end

          it 'returns presigned and public urls' do
            expect(json["shipment"]["data"]["attributes"]["shipments"][0]["cod_value"]).to eq(
              @shipment_params[:data][:attributes]["shipments_attributes"][0]["cod_value_attributes"])
            expect(json["shipment"]["data"]["attributes"]["shipments"][0]["shipment_value"]).to eq(
              @shipment_params[:data][:attributes]["shipments_attributes"][0]["shipment_value_attributes"])
          end
        end

        response '400', :unauthorized do
          let(:token)  { '' }

          run_test!
        end

        response '401', :unauthorized do
          let(:token)  { jwt_expired }

          run_test!
        end
      end
    end
  end

  path '/fedex_integration/shipments/{shipment_id}' do
    get 'Show Shipment' do
      tags 'Fedex Integration'
      parameter name: 'token', in: :header, type: :string, default: '{{bx_blocks_api_token}}'
      parameter name: :shipment_id, in: :path, type: :integer
      let(:create_shipment) { create(:create_shipment,
        shipments_attributes: @shipment_params[:data][:attributes]["shipments_attributes"]) }

      let(:shipment_id) { create_shipment.id }

      let(:observed_response_json) do
        {
          "shipment" => {
            "data"=>{
              "id"=> create_shipment.id.to_s,
              "type"=>"create_shipment",
              "attributes"=>{
                "auto_assign_drivers"=>create_shipment.auto_assign_drivers,
                "requested_by"=>create_shipment.requested_by,
                "shipper_id"=>create_shipment.shipper_id,
                "shipments"=>[
                  {
                    "ref_id"=>create_shipment.shipments.first.ref_id,
                    "full_truck"=>create_shipment.shipments.first.full_truck,
                    "load_description"=>create_shipment.shipments.first.load_description,
                    "cod_value"=>{
                      "amount"=> create_shipment.shipments.first.cod_value.amount,
                      "currency"=> create_shipment.shipments.first.cod_value.currency
                    },
                    "shipment_value"=>{
                      "amount"=> create_shipment.shipments.first.shipment_value.amount,
                      "currency"=> create_shipment.shipments.first.shipment_value.currency
                    },
                    "delivery"=>{
                      "address"=>create_shipment.shipments.first.delivery.address,
                      "address2"=>create_shipment.shipments.first.delivery.address2,
                      "city"=>create_shipment.shipments.first.delivery.city,
                      "country"=>create_shipment.shipments.first.delivery.country,
                      "email"=>create_shipment.shipments.first.delivery.email,
                      "name"=>create_shipment.shipments.first.delivery.name,
                      "phone"=>create_shipment.shipments.first.delivery.phone,
                      "instructions"=>create_shipment.shipments.first.delivery.instructions,
                      "arrival_window"=> {
                        "exclude_begin"=>create_shipment.shipments.first.delivery.arrival_window.exclude_begin,
                        "exclude_end"=>create_shipment.shipments.first.delivery.arrival_window.exclude_end,
                        "begin"=>create_shipment.shipments.first.delivery.arrival_window.begin_at.as_json,
                        "end"=>create_shipment.shipments.first.delivery.arrival_window.end_at.as_json
                      },
                      "coordinate"=>{
                        "latitude"=>create_shipment.shipments.first.delivery.coordinate.latitude,
                        "longitude"=>create_shipment.shipments.first.delivery.coordinate.longitude
                      }
                    },
                    "pickup"=>{
                      "address"=>create_shipment.shipments.first.pickup.address,
                      "address2"=>create_shipment.shipments.first.pickup.address2,
                      "city"=>create_shipment.shipments.first.pickup.city,
                      "country"=>create_shipment.shipments.first.pickup.country,
                      "email"=>create_shipment.shipments.first.pickup.email,
                      "name"=>create_shipment.shipments.first.pickup.name,
                      "phone"=>create_shipment.shipments.first.pickup.phone,
                      "arrival_window"=> {
                        "exclude_begin"=>create_shipment.shipments.first.pickup.arrival_window.exclude_begin,
                        "exclude_end"=>create_shipment.shipments.first.pickup.arrival_window.exclude_end,
                        "begin"=>create_shipment.shipments.first.pickup.arrival_window.begin_at.as_json,
                        "end"=>create_shipment.shipments.first.pickup.arrival_window.end_at.as_json
                      },
                      "coordinate"=>{
                        "latitude"=>create_shipment.shipments.first.pickup.coordinate.latitude,
                        "longitude"=>create_shipment.shipments.first.pickup.coordinate.longitude
                      }
                    },
                    "items"=>[
                      {
                        "ref_id"=>create_shipment.shipments.first.items.first.ref_id,
                        "weight"=>create_shipment.shipments.first.items.first.weight,
                        "quantity"=>create_shipment.shipments.first.items.first.quantity,
                        "stackable"=>create_shipment.shipments.first.items.first.stackable,
                        "type"=>create_shipment.shipments.first.items.first.item_type,
                        "dimensions"=>{
                          "height"=>create_shipment.shipments.first.items.first.dimension.height,
                          "length"=>create_shipment.shipments.first.items.first.dimension.length,
                          "width"=>create_shipment.shipments.first.items.first.dimension.width
                        }
                      }
                    ]
                  }
                ]
              }
            }
          }
        }
      end
      context 'success' do
        response '200', :success do
          schema type: :object,
                  properties: {
                    shipment: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        type: { type: :string },
                        attributes: {
                          auto_assign_drivers: { type: :boolean },
                          requested_by: { type: :string },
                          shipper_id: { type: :string },
                          shipments: {
                            type: :array,
                            items: {
                              type: :object,
                              properties: {
                                ref_id: { type: :string },
                                full_truck: { type: :boolean },
                                load_description: { type: :string },
                                cod_value: {
                                  type: :object,
                                  properties: {
                                    amount: { type: :float },
                                    currency: { type: :string }
                                  }
                                },
                                shipment_value: {
                                  type: :object,
                                  properties: {
                                    amount: { type: :float },
                                    currency: { type: :string }
                                  }
                                },
                                delivery: {
                                  type: :object,
                                  properties: {
                                    address: { type: :string },
                                    address2: { type: :string },
                                    city: { type: :string },
                                    country: { type: :string },
                                    email: { type: :string },
                                    name: { type: :string },
                                    phone: { type: :string },
                                    instructions: { type: :string },
                                    arrival_window: {
                                      type: :object,
                                      properties: {
                                        exclude_begin: { type: :boolean },
                                        exclude_end: { type: :boolean },
                                        begin: { type: :string },
                                        end: { type: :string }
                                      }
                                    },
                                    coordinate: {
                                      type: :object,
                                      properties: {
                                        latitude: { type: :boolean },
                                        longitude: { type: :boolean },
                                      }
                                    }
                                  }
                                },
                                pickup: {
                                  type: :object,
                                  properties: {
                                    address: { type: :string },
                                    address2: { type: :string },
                                    city: { type: :string },
                                    country: { type: :string },
                                    email: { type: :string },
                                    name: { type: :string },
                                    phone: { type: :string },
                                    arrival_window: {
                                      type: :object,
                                      properties: {
                                        exclude_begin: { type: :boolean },
                                        exclude_end: { type: :boolean },
                                        begin: { type: :string },
                                        end: { type: :string }
                                      }
                                    },
                                    coordinate: {
                                      type: :object,
                                      properties: {
                                        latitude: { type: :boolean },
                                        longitude: { type: :boolean },
                                      }
                                    }
                                  }
                                },
                                items: {
                                  type: :array,
                                  items: {
                                    type: :object,
                                    properties: {
                                      ref_id: { type: :string },
                                      weight: { type: :float },
                                      quantity: { type: :integer },
                                      stackable: { type: :boolean },
                                      type: { type: :integer },
                                      dimensions: {
                                        type: :object,
                                        properties: {
                                          height: { type: :float },
                                          length: { type: :float },
                                          width: { type: :float },
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

          before do |example|
            VCR.use_cassette('fedex_shipment_get') do
              submit_request(example.metadata)
            end
          end

          it 'returns correct result' do
            expect(observed_response_json["shipment"]["data"]["attributes"]["shipments"][0]["cod_value"]).to eq(
              json["shipment"]["data"]["attributes"]["shipments"][0]["cod_value"])
            expect(observed_response_json["shipment"]["data"]["attributes"]["shipments"][0]["shipment_value"]).to eq(
              json["shipment"]["data"]["attributes"]["shipments"][0]["shipment_value"])
            expect(observed_response_json["shipment"]["data"]["attributes"]["shipments"][0]["delivery"]).to eq(
              json["shipment"]["data"]["attributes"]["shipments"][0]["delivery"])
          end
        end
      end
    end
  end
end
