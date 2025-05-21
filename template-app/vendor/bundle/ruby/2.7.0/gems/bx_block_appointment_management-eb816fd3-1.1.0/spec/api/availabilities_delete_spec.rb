
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

  path '/appointment_management/availabilities/{service_provider_id}' do
    delete 'Delete Availability' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_appointment_management', 'Availability', 'destroy'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :service_provider_id, in: :path, type: :string

      let!(:account) { create :account }

      let!(:availability) { FactoryBot.create(:availability, service_provider_id: account.id) }

      let!(:service_provider_id) { account.id }
      response '200', :success do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        context 'Should have status 200' do
          run_test! do |response|
            expect(response.status).to eq 200
          end
        end
        context 'Should have same reponse' do
          run_test! do |response|
            json_response = JSON.parse(response.body)
            expect(json_response['message']).to eq('Availability deleted successfully')
          end
        end
      end
    end
  end
end
