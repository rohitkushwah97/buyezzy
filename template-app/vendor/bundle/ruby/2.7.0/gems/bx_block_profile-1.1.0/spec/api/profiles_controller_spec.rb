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
  let(:account2) { create :email_account }

  path '/profile/profiles' do
    post 'Create a Profile' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profiles', 'create'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          profile: {
            type: :object,
            properties: {
              country: {type: :string},
              city: {type: :string},
              address: {type: :string},
              postal_code: {type: :string}
            }
          }
        },
        required: ['country']
      }

      let(:params) do
        {
          profile: {
            country: 'US',
            city: 'Los Angeles',
            address: 'Address',
            postal_code: '123'
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
          expect(response.status).to eq 201
          expect(attrs['country']).to eq 'US'
          expect(attrs['city']).to eq 'Los Angeles'
          expect(attrs['postal_code']).to eq '123'
        end
      end

      context 'given an invalid profile params' do
        let(:params) do
          {
            profile: {
              country: '',
              city: 'Los Angeles',
              address: 'Address',
              postal_code: '123'
            }
          }
        end
        response '422', :unprocessable_entity do
          run_test!
          it 'invalide profile' do
            expect(response.status).to eq 422
          end
        end
      end

    end
  end

  path '/profile/profiles/{profile_id}' do
    get 'Get a profile' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profiles', 'index'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :profile_id, in: :path, type: :integer

      let!(:profile) { create(:profile, account_id: account.id) }

      let(:profile_id) { profile.id }

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

        context 'given valid parameters' do
          context 'profile record exist' do
            it 'should show the profile with the given id' do
              expect(response.status).to eq 200
              expect(attrs['country']).to eq profile.country
              expect(attrs['city']).to eq profile.city
              expect(attrs['postal_code']).to eq profile.postal_code
            end
          end
        end
      end
    end
  end

  path '/profile/profiles/{profile_id}/update_profile' do
    put 'Update a Profile' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profiles', 'update'
      let!(:profile) { create(:profile, account_id: account.id) }
      let(:profile_id) { profile.id }
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :profile_id, in: :path, type: :integer
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          profile: {
            type: :object,
            properties: {
              country: {type: :string},
              city: {type: :string},
              address: {type: :string},
              postal_code: {type: :string}
            }
          }
        }
      }

      let(:params) do
        {
          profile: {
            country: 'US',
            city: 'Los Angeles',
            address: 'Address',
            postal_code: '123'
          }
        }
      end

      let!(:profile) { create(:profile, account_id: account.id) }

      let(:id) { profile.id }

      response '200', :ok do
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
                  account_id: {type: :integer}
                }
              }
            }
          }
        }

        before do |example|
          submit_request(example.metadata)
        end

        it 'updates the account' do
          expect(attrs['country']).to eq 'US'
          expect(attrs['city']).to eq 'Los Angeles'
          expect(attrs['postal_code']).to eq '123'
        end
      end
    end
  end

  path '/profile/profiles/{profile_id}' do
    delete 'Delete a Profile' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profiles', 'Delete'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true
      parameter name: :profile_id, in: :path, type: :integer

      let!(:profile) { create(:profile, account_id: account.id) }
      let(:profile_id) { profile.id }

      response '200', :success do
        schema '$ref' => '#/components/schemas/profile_block'
        schema type: :object,
          properties: {
            message: {type: :string}
          }

        before do |example|
          submit_request(example.metadata)
        end

        it 'Should have status 200' do
          expect(response.status).to eq 200
        end

        it 'Should have same reponse' do
          json_response = JSON.parse(response.body)
          expect(json_response['message']).to eq('Profile Removed')
        end
      end
      context 'given an invalid profile' do
        let!(:profile) { create(:profile, account_id: account2.id) }
        let(:profile_id) { profile.id }
        response '401', :unprocessable_entity do
          before do |example|
            submit_request(example.metadata)
          end

          it 'invalide profile' do
            expect(response.status).to eq 401
          end
        end
      end
    end
  end
end

