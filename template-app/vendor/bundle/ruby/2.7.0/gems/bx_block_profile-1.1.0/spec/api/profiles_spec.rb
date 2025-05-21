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
  let!(:profile) { create(:profile, account_id: account.id) }

  path '/profile/profile/{id}' do
    get 'Get a Profile' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profile', 'index'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :id, in: :path, type: :integer

      let(:id) { profile.id }

      context 'given valid token' do
        response '200', :success do
          schema '$ref' => '#/components/schemas/profile_block'
          schema type: :object, properties: {
            data: {
              type: :object,
              properties: {
                id: {type: :string},
                type: {type: :string},
                attributes: {
                  type: :object,
                  properties: {
                    id: {type: :integer},
                    country: {type: :string},
                    address: {type: :string},
                    city: {type: :string},
                    postal_code: {type: :string},
                    account_id: {type: :integer},
                    photo: {type: :string}
                  }
                }
              }
            }
          }

          before do |example|
            submit_request(example.metadata)
          end

          it 'returns the account profile details' do
            expect(response.status).to eq 200
            expect(data['id'].to_i).to eq profile.id
            expect(data['type']).to eq 'profile'
            expect(attrs['account_id']).to eq account.id
          end
        end
      end

      context 'given an invalid token' do
        response '400', :unauthorized do
          let(:token) { 'invalid_token' }

          before do |example|
            submit_request(example.metadata)
          end

          it 'indicates an invalid token error' do
            expect(error).to match({'token' => 'Invalid token'})
          end
        end
      end

      context 'given an expired token' do
        response '401', :unauthorized do
          let(:token) { jwt_expired }

          before do |example|
            submit_request(example.metadata)
          end

          it 'indicates that the token has expired' do
            expect(response.status).to eq 401
            expect(error['token']).to match(/expired/i)
          end
        end
      end
    end
  end

  path '/profile/account' do
    put 'Update a profile' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profile', 'update'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              first_name: {type: :string},
              last_name: {type: :string},
              current_password: {type: :string},
              new_password: {type: :string},
              new_phone_number: {type: :string},
              new_email: {type: :string}
            }
          }
        },
        required: ['new_phone_number']
      }

      let(:id) { profile.id }
      let(:phone) { generate :phone_number }
      let(:new_phone) { generate :phone_number }
      let(:new_password) { "#{account.password}aA1!" }
      let(:new_email) { generate :account_email }
      let(:email) { generate :account_email }
      let(:password) { account.password }

      let(:params) do
        {
          data: {
            first_name: "#{account.first_name}-updated",
            last_name: "#{account.last_name}-updated",
            current_password: password,
            new_password: new_password,
            new_phone_number: new_phone,
            new_email: new_email
          }
        }
      end

      context 'given an email account' do
        let(:account) do
          create :email_account,
            activated: true,
            first_name: 'Firstname',
            last_name: 'Lastname',
            password: 'password',
            full_phone_number: phone
        end

        context 'given valid updates' do
          let(:new_email) { nil }
          response '200', :success do
            schema '$ref' => '#/components/schemas/profile_block'
            schema type: :object, properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string},
                  type: {type: :string},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer},
                      country: {type: :string},
                      address: {type: :string},
                      city: {type: :string},
                      postal_code: {type: :string},
                      account_id: {type: :integer},
                      photo: {type: :string}
                    }
                  }
                }
              }
            }

            before do |example|
              submit_request(example.metadata)
            end

            it 'updates the account' do
              expect(response.status).to eq 200
              expect(attrs['first_name']).to eq 'Firstname-updated'
              expect(attrs['last_name']).to eq 'Lastname-updated'
              expect(attrs['phone_number']).to_not eq account.phone_number
              expect(attrs['phone_number']).to match new_phone.last(4)
            end
          end

          context 'given an invalid phone number' do
            response '422', :unprocessable_entity do
              let(:new_phone) { 'invalid-phone' }

              before do |example|
                submit_request(example.metadata)
              end

              it 'indicates that the number is not valid' do
                expect(response.status).to eq 422
                expect(error['profile']).to match(/phone.*is not valid/)
                expect(account.authenticate(password)).to be_a ActiveRecord::Base
              end
            end
          end

          context 'given an invalid password' do
            response '422', :unprocessable_entity do
              let(:new_password) { 'invalid-password' }

              before do |example|
                submit_request(example.metadata)
              end

              it 'indicates that the number is not valid' do
                expect(response.status).to eq 422
                expect(error['profile']).to match(/password is invalid/i)
              end
            end
          end
        end

        context 'given email is included' do
          response '422', :unprocessable_entity do
            before do |example|
              submit_request(example.metadata)
            end

            it 'does not allow any changes' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/cannot be edited/i)
            end
          end
        end
      end

      context 'given an sms account' do
        let(:account) do
          create :sms_account,
            activated: true,
            first_name: 'Firstname',
            last_name: 'Lastname',
            password: 'password',
            email: email
        end

        context 'given valid updates' do
          let(:new_phone) { nil }

          response '200', :success do
            schema type: :object, properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string},
                  type: {type: :string},
                  attributes: {
                    type: :object,
                    properties: {
                      id: {type: :integer},
                      country: {type: :string},
                      address: {type: :string},
                      city: {type: :string},
                      postal_code: {type: :string},
                      account_id: {type: :integer},
                      photo: {type: :string}
                    }
                  }
                }
              }
            }

            before do |example|
              submit_request(example.metadata)
            end

            it 'updates the account' do
              expect(response.status).to eq 200
              expect(attrs['first_name']).to eq 'Firstname-updated'
              expect(attrs['last_name']).to eq 'Lastname-updated'
              expect(attrs['email']).to eq new_email
            end
          end
        end

        context 'given phone is included' do
          response '422', :unprocessable_entity do
            before do |example|
              submit_request(example.metadata)
            end

            it 'does not allow any changes' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/cannot be edited/i)
              expect(account.authenticate(password)).to be_a ActiveRecord::Base
            end
          end
        end

        context 'given an invalid email is included' do
          response '422', :unprocessable_entity do
            let(:new_phone) { nil }
            let(:new_email) { 'invalid-email' }
            before do |example|
              submit_request(example.metadata)
            end

            it 'does not allow any changes' do
              expect(response.status).to eq 422
              expect(error['profile']).to match(/email.*is not valid/)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
