require 'swagger_helper'
include PushNotificationsApiHelper

RSpec.describe '/bx_block_push_notifications', :jwt do

  let(:json)   { JSON response.body }
  let(:data)   { json['data'] }
  let(:token)  { jwt }
  let(:attributes) { data['attributes']}
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }
  let(:model_errors) { data['attributes']['errors'] }
  let(:model_error)  { errors.first }
  let(:account) { create :email_account }
  let(:id)      { account.id }
  let!(:push_notificable) { create :account, email: 'customer1@yopmail.com', password: '123456' }
  let!(:push_notification1) { create :push_notification,
    valid_attributes.merge(account: push_notificable, push_notificable: account) }
  let(:valid_attributes) {
      attributes_for(:push_notification)
    }
  let(:push_notification_id) { push_notification1.id }
  let(:added_params) { valid_attributes.merge({
      "push_notificable_type"=> push_notificable.class.name,
      "push_notificable_id"=> push_notificable.id
    })
  }

  let(:update_push_notifications) do
    {
      "data" => {
        "attributes"=> valid_attributes.merge({ "is_read"=> true })
      }
    }
  end


  path '/push_notifications/push_notifications' do

    get 'List Push Notification' do
      tags 'Push Notification'
      parameter name: 'token', in: :header, type: :string, default: '{{bx_blocks_api_token}}'

      response '200', :success do
        schema type: :object,
              properties: {
                company_info: {
                  type: :array,
                  items: {
                    id: { type: :string },
                    name: { type: :string },
                    created_at: { type: :date },
                    updated_at: { type: :date },
                    industry: { type: :string },
                    company_type: { type: :string },
                    headquarters: { type: :string },
                    no_of_employees: { type: :string },
                    type_of_company: { type: :string },
                    tagline: { type: :string },
                    public_link: { type: :string },
                    about_the_company: { type: :string },
                    services: { type: :string },
                    approved: { type: :boolean },
                    email: { type: :string },
                    ceo_of_company: { type: :string },
                    established_in: { type: :date },
                    contact_details: {
                      type: :array,
                      items: {
                        type: :object,
                        properties: {
                          id: { type: :integer},
                          established_in: { type: :date },
                          phone_number: { type: :string },
                          email: { type: :string },
                          address: { type: :string },
                          city: { type: :string },
                          state: { type: :string },
                          company_id: { type: :string },
                          created_at: { type: :string },
                          updated_at: { type: :string },
                        }
                      }
                    },
                    logo: { type: :string }
                  }
                }
              }

        before do |example|
          submit_request(example.metadata)
        end

        it 'should return list of push notification' do
          authenticated_header(request, push_notificable)
          valid_attributes[:account_id] = account.id
          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(200)
        end

        response '400', :unauthorized do
          let(:token)  { '' }

          run_test!
        end
      end
    end

    post 'Create new Push Notification' do
      tags 'Push Notification'
      consumes 'application/json'
      produces 'application/json'
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
                  push_notificable_type: { type: :string },
                  push_notificable_id: { type: :integer },
                  remarks: {type: :string },
                  is_read: { type: :boolean }
                }
              }
            }
          }
        }
      }

      let(:params) do
        {
          data: { attributes:  added_params }
        }
      end

      response '201', :success do
        schema type: :object,
                properties: {
                  data: {
                    type: :object,
                    properties: {
                      id: { type: :string },
                      type: { type: :string },
                      attributes: {
                        type: :object,
                        properties: {
                          push_notificable_id: { type: :integer },
                          push_notificable_type: { type: :string },
                          remarks: { type: :string },
                          is_read: { type: :boolean },
                          created_at: { type: :date },
                          updated_at: { type: :date },
                          account: {
                            type: :object,
                            properties: {
                              data: {
                                type: :object,
                                properties: {
                                  id: { type: :string },
                                  type: { type: :string },
                                  attributes: {
                                    type: :object,
                                    properties: {
                                      first_name: { type: :string },
                                      last_name: { type: :string },
                                      full_phone_number: { type: :string },
                                      country_code: { type: :string },
                                      phone_number: { type: :string },
                                      email: { type: :string },
                                      activated: { type: :boolean }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          looking_for: { type: :array },
                          profile_image: { type: :string }
                        }
                      }
                    }
                  }
                }

        before do |example|
          BxBlockPushNotifications::PushNotification.delete_all
          submit_request(example.metadata)
        end

        it 'create push notification with valid attributes ' do
          expect(json).not_to be_blank
          expect(response).to have_http_status(200)
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


  path '/push_notifications/push_notifications/{push_notification_id}' do
    get 'Show Push Notifications' do
      tags 'Push Notifications'
      parameter name: 'token', in: :header, type: :string, default: '{{bx_blocks_api_token}}'
      parameter name: :push_notification_id, in: :path, type: :integer
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  valid_attributes: {
                    type: :object,
                    properties: {
                      valid_attributes: {
                        remarks: { type: :string },
                        is_read: { type: :boolean}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      let(:params) do
        {
          data: { attributes:  valid_attributes }
        }
      end

      response '200', :success do
        schema type: :object,
                properties: {
                  data: {
                    type: :object,
                    properties: {
                      id: { type: :string },
                      type: { type: :string },
                      attributes: {
                        type: :object,
                        properties: {
                          push_notificable_id: { type: :integer },
                          push_notificable_type: { type: :string },
                          remarks: { type: :string },
                          is_read: { type: :boolean },
                          created_at: { type: :date },
                          updated_at: { type: :date },
                          account: {
                            type: :object,
                            properties: {
                              data: {
                                type: :object,
                                properties: {
                                  id: { type: :string },
                                  type: { type: :string },
                                  attributes: {
                                    type: :object,
                                    properties: {
                                      first_name: { type: :string },
                                      last_name: { type: :string },
                                      full_phone_number: { type: :string },
                                      country_code: { type: :string },
                                      phone_number: { type: :string },
                                      email: { type: :string },
                                      activated: { type: :boolean }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          looking_for: { type: :array },
                          profile_image: { type: :string }
                        }
                      }
                    }
                  }
                }
        before do |example|
          submit_request(example.metadata)
        end

        it 'show push notification with valid attributes ' do
          authenticated_header(request, push_notificable)
          expect(json).not_to be_blank
          expect(response).to have_http_status(200)
        end
      end
    end

    put 'Update Push Notifications' do
      tags 'Push Notifications'
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'token', in: :header, type: :string, default: '{{bx_blocks_api_token}}'
      parameter name: :push_notification_id, in: :path, type: :integer
      parameter name: :update_push_notifications, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  remarks: { type: :string },
                  is_read: { type: :boolean }
                }
              }
            }
          }
        }
      }

      context 'given valid parameters' do
        response '200', :success do
         schema type: :object,
                properties: {
                  data: {
                    academic_qualification: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        academic_board: { type: :string},
                        account_id: { type: :integer },
                        school: { type: :string },
                        location: { type: :string },
                        course_name: { type: :string },
                        start_year: { type: :string },
                        end_year: { type: :string },
                        grade: { type: :string },
                        created_at: { type: :string },
                        updated_at: { type: :string },
                        degree: { type: :string },
                        specialization: { type: :string },
                        institute: { type: :string },
                      },
                      code: { type: :integer },
                      message: { type: :integer }
                    }
                  }
                }
          before do |example|
            submit_request(example.metadata)
          end

          it 'update push notification with valid attributes ' do
            authenticated_header(request, push_notificable)

            expect(json).not_to be_blank
            push_notification1.reload
            expect(push_notification1.is_read).to eq true
            expect(response).to have_http_status(200)
          end
        end
      end
    end
  end
end
