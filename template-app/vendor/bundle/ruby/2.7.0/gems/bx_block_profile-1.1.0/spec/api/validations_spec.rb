# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/profile', :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json['data'] }
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:settings) { data.first }

  let(:account) { create :email_account }
  let!(:profile) { create(:profile, account_id: account.id) }

  path '/profile/validations' do
    get 'validations' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_profile', 'profile', 'index'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}',required: true

      response '200', :success do
        schema '$ref' => '#/components/schemas/profile_block'
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: {
              email_validation_regexp: {type: :string},
              password_validation_regexp: {type: :string},
              password_validation_rules: {type: :string}
            }
          }
        }

        before do |example|
          submit_request(example.metadata)
        end

        context 'given valid params' do
          it 'returns profile validations' do
            expect(response.status).to eq 200
            expect(data.count).to eq 1
            expect(settings.keys).to match_array %w[
              email_validation_regexp
              password_validation_regexp
              password_validation_rules
            ]

            expect(settings['password_validation_rules']).to match(/password should be/i)
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
