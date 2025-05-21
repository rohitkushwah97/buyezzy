

require 'swagger_helper'

RSpec.describe '/bx_block_appointment_management', :jwt do
  let(:headers) { { token: token } }

  let(:json) { JSON response.body }
  let(:data) { json['data'] }
  let(:token) { jwt }
  let(:errors) { json['errors'] }
  let(:error) { errors.first }

  let(:customer) { create :email_account }
  let(:service_provider) { create :email_account }
  let(:id) { customer.id }
  let(:availability) { create :availability }

  let(:token) { BuilderJsonWebToken.encode(customer.id, 1.day.from_now, token_type: 'login') }

  path '/appointment_management/availabilities' do
    post 'Create Availability' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_appointment_management', 'Appointment Management', 'create'

      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :params, in: :body,
                schema: {
                  type: :object,
                  properties: {
                    "start_time": {
                      "type": 'string'
                    },
                    "end_time": {
                      "type": 'string'
                    },
                    "availability_date": {
                      "type": 'string'
                    }
                  }
                }

      context 'success' do
        let(:params) do
          {
            availability: {
              start_time: '10:00 AM',
              end_time: '10:00 PM',
              availability_date: DateTime.now.strftime('%d/%m/%Y')
            }
          }
        end

        response '201', :success do
          before do
            allow(BxBlockAppointmentManagement::CreateAvailabilityWorker).to receive(:perform_async)
          end
          schema '$ref' => '#/components/schemas/availablity'

          context 'should have status 201' do
            run_test! do |response|
              json_response = JSON.parse(response.body)
              expect(response.status).to eq 201
            end
          end
        end

        response '400', :unauthorized do
          let(:token) { '' }

          run_test!
        end

        response '401', :unauthorized do
          let(:token) { jwt_expired }

          run_test!
        end
      end

      context 'failure' do
        let(:params) do
          {
            availability: {
              end_time: '10:00 PM',
              availability_date: DateTime.now.strftime('%d/%m/%Y')
            }
          }
        end

        response '422', :unprocessable_entity do
          context 'Create availability for the service provider by wrong params' do
            run_test! do |response|
              json_response = JSON.parse(response.body)
              expect(json_response['errors'].first['slot_error']).to eq "Start time can't be blank"
              expect(response.status).to eq 422
            end
          end

          context 'Create availability for no time' do
            let(:params) do
              {
                availability: {
                  end_time: '',
                  availability_date: DateTime.now.strftime('%d/%m/%Y')
                }
              }
            end
            run_test! do |response|
              json_response = JSON.parse(response.body)
              expect(json_response['errors'].first['slot_error']).to eq "Start time can't be blank"
              expect(response.status).to eq 422
            end
          end
        end
      end
    end

    get 'List Availability' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_appointment_management', 'Appointment Management', 'index'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :service_provider_id, in: :query, type: :string
      parameter name: :availability_date, in: :query, type: :string

      let!(:availability1) { create :availability, service_provider: service_provider }
      let(:service_provider_id) { availability1.service_provider_id }
      let(:availability_date) { DateTime.now.strftime('%d/%m/%Y') }
      let!(:booked_slot) { create :booked_slot, service_provider: service_provider }

      response '200', :success do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   items: {
                     id: { type: :integer },
                     type: { type: :string },
                     attributes: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         availability_date: { type: :string },
                         time_slots: {
                           type: :array,
                           items: {
                             from: { type: :string },
                             to: { type: :string },
                             booked_status: { type: :boolean },
                             sno: { type: :string }
                           }
                         }
                       }
                     }
                   }
                 }
               }

        context 'Create availability for the service provider by correct params' do
          run_test! do |response|
            expect(response.status).to eq 200
          end
        end

        context 'Should have same reponse' do
          run_test! do |response|
            json_response = JSON.parse(response.body)
            expect(json_response['data']['attributes']['id']).to eq availability1.id
          end
        end
      end
    end
  end
end
