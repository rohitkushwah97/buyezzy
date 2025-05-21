# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/notifsettings', :jwt do
  let(:token) { jwt }
  let(:headers) { { token: token } }
  let(:json)   { JSON response.body }
  let(:data)   { json['data'] }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }
  let(:model_errors) { data['attributes']['errors'] }
  let(:model_error)  { errors.first }
  let(:account) { create :email_account }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: 'login') }
  let(:id)      { account.id }
  let(:notification_setting) { create :notification_setting }

  path '/notifsettings/notification_settings' do
    post 'notification_settings' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_settings', 'create'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :data, in: :body, schema: {
        type: :object,

        properties: {
          title: { type: :string },
          description: { type: :string },

          state: { type: :string }

        },
        required: %w[title description group_name state]
      }

      let(:data) do
        {

          "title": 'bx_block_notifsettings',
          "description": 'bx_block_notifsettings 2',
          "state": 'active'
        }
      end

      response '201', :success do
        schema '$ref' => '#/components/schemas/notification_settings'
        run_test! { |response| expect(response.status).to eq 201 }
      end

      context 'given  token invalid' do
        response '400', :bad_request do
          let(:token) { '' }
          run_test!
        end
      end

      response '401', :unauthorized do
        let(:token) { jwt_expired }
        run_test!
      end
    end
  end

  path '/notifsettings/notification_settings/{id}' do
    put 'notification_settings' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_settings', 'update'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :data, in: :body, schema: {
        type: :object,

        properties: {
          title: { type: :string },
          description: { type: :string },

          state: { type: :string }

        },
        required: %w[title description group_name state]
      }

      let(:data) do
        {

          "title": 'bx_block_notifsettings',
          "state": 'active'

        }
      end
      let(:notification_setting) { create :notification_setting }
      let(:id) { notification_setting.id }
      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_settings'
        run_test! { |response| expect(response.status).to eq 200 }
      end

      context 'given  token invalid' do
        response '400', :bad_request do
          let(:token) { '' }
          run_test!
        end
      end

      response '401', :unauthorized do
        let(:token) { jwt_expired }
        run_test!
      end
    end
  end

  path '/notifsettings/notification_settings/{id}' do
    get 'notification_settings' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_settings', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true

      let(:notification_setting) { create :notification_setting }
      let(:id) { notification_setting.id }
      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_settings'
        run_test! { |response| expect(response.status).to eq 200 }
      end

      context 'given  token invalid' do
        response '400', :bad_request do
          let(:token) { '' }
          run_test!
        end
      end

      response '401', :unauthorized do
        let(:token) { jwt_expired }
        run_test!
      end
    end
  end

  path '/notifsettings/notification_settings' do
    get 'notification_settings' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_settings', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      #   parameter name: :id, in: :path, type: :string, required: true

      let(:notification_setting) { create :notification_setting }
      # let(:id) { notification_setting.id }
      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_settings'
        run_test! { |response| expect(response.status).to eq 200 }
      end

      context 'given  token invalid' do
        response '400', :bad_request do
          let(:token) { '' }
          run_test!
        end
      end

      response '401', :unauthorized do
        let(:token) { jwt_expired }
        run_test!
      end
    end
  end

  path '/notifsettings/notification_settings/{id}' do
    delete 'notifsettings' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notifsettings', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true

      let(:notification_setting) { create :notification_setting }
      let(:id) { notification_setting.id }
      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_settings'
        run_test! { |response| expect(response.status).to eq 200 }
      end

      context 'given  token invalid' do
        response '400', :bad_request do
          let(:token) { '' }
          run_test!
        end
      end

      response '401', :unauthorized do
        let(:token) { jwt_expired }
        run_test!
      end
    end
  end
end
