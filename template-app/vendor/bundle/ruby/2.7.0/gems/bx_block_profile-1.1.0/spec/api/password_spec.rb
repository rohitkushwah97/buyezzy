# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/profile', :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json['data'] }
  let(:attrs) { data['attributes'] }
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:errors) { json['errors'] }
  let(:error) { errors.first }

  let(:account) { create :email_account }

  path '/profile/password' do
    put 'Change password' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profiles', 'create'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              current_password: {type: :string},
              new_password: {type: :string}
            }
          }
        },
        required: ['password']
      }

      let(:current_password) { account.password }
      let(:new_password) { "#{account.password}A1!" }

      let(:params) do
        {
          data: {
            current_password: current_password,
            new_password: new_password
          }
        }
      end

      context 'given a valid password' do
        context 'given the new password is valid' do
          response '201', :created do
            schema type: :object, properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string},
                  type: {type: :string},
                  attributes: {
                    type: :object,
                    properties: {
                      activated: {type: :boolean},
                      country_code: {type: :string},
                      email: {type: :string},
                      first_name: {type: :string},
                      full_phone_number: {type: :string},
                      last_name: {type: :integer},
                      phone_number: {type: :string},
                      type: {type: :string},
                      unique_auth_id: {type: :string}
                    }
                  }
                },
                required: ['new_phone_number']
              }
            }

            before do |example|
              submit_request(example.metadata)
            end

            it 'updates the password' do
              expect(response.status).to eq 201
              expect(data['id'].to_i).to eq account.id
            end
          end
        end

        context 'given the new password is not valid' do
          response '422', :unprocessable_entity do
            let(:new_password) { 'invalid-password' }
            before do |example|
              submit_request(example.metadata)
            end

            it 'indicates that the new password is invalid' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/password.*invalid/i)
            end
          end
        end
      end

      context 'given an invalid password' do
        context 'given the new password is valid' do
          response '422', :unprocessable_entity do
            let(:current_password) { "#{account.password}-old" }
            before do |example|
              submit_request(example.metadata)
            end

            it 'indicates that the credentials are invalid' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/invalid .*credentials/i)
            end
          end
        end

        context 'given the new password is not valid' do
          response '422', :unprocessable_entity do
            let(:current_password) { "#{account.password}-old" }
            let(:new_password) { 'invalid-password' }
            before do |example|
              submit_request(example.metadata)
            end

            it 'indicates that the credentials are invalid' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/invalid .*credentials/i)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
