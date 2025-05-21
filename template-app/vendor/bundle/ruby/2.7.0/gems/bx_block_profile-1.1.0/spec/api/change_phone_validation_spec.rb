# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/profile', :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:messages) { json['messages'] }
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:errors) { json['errors'] }
  let(:error) { errors.first }

  let(:account) { create :email_account }
  let!(:profile) { create(:profile, account_id: account.id) }

  path '/profile/change_phone_validation' do
    post 'change phone validation' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'Change phone validation', 'create'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              new_phone_number: {type: :string}
            }
          }
        },
        required: ['new_phone_number']
      }

      context 'given an email account' do
        let(:new_phone_number) { '+1 234 567 9000' }

        let(:params) do
          {
            data: {
              new_phone_number: new_phone_number
            }
          }
        end

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
                    new_phone_number: {type: :string}
                  },
                  required: ['new_phone_number']
                }
              }
            }
          }

          before do |example|
            submit_request(example.metadata)
          end

          context 'given a valid phone number' do
            it 'indicates that the phone number may be changed' do
              expect(response.status).to eq 201
              expect(messages[0]['profile']).to match(/phone.*change.*valid/i)
            end
          end

          context 'given an invalid phone number' do
            let(:new_phone_number) { 'invalid-phone' }
            it 'indicates that the new phone number is invalid' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/number is not valid/i)
            end
          end
        end
      end

      context 'given an sms account' do
        let(:account) { create :sms_account, activated: true }
        let(:new_phone_number) { '+1 234 567 9000' }

        let(:params) do
          {
            data: {
              new_phone_number: new_phone_number
            }
          }
        end

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
                    new_phone_number: {type: :string}
                  }
                }
              }
            }
          }

          before do |example|
            submit_request(example.metadata)
          end

          context 'given a valid phone number' do
            it 'indicates that the number may not be changed' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/field cannot be edited/i)
            end
          end

          context 'given an invalid phone number' do
            let(:new_phone_number) { 'invalid-phone' }

            it 'indicates that the number may not be changed' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/field cannot be edited/i)
            end
          end
        end
      end
    end
  end
end

