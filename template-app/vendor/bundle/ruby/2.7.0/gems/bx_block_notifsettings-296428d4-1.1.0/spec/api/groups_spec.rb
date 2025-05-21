# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/notifsettings', :jwt do
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

  path '/notifsettings/groups' do
    post 'notification_group' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_group', 'create'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :data, in: :body, schema: {
        type: :object,

        properties: {
          notification_setting_id: { type: :integer },
          group_type: { type: :string },
          group_name: { type: :string },
          state: { type: :string }

        },
        required: %w[notification_setting_id group_type group_name state]
      }

      let(:data) do
        {
          "notification_setting_id": notification_setting.id,
          "group_type": 'account_group',
          "group_name": 'Group 1',
          "state": 'active'
        }
      end

      response '201', :success do
        schema '$ref' => '#/components/schemas/notification_group'
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

      response '404', :unauthorized do
        context 'given invalid state' do
          let(:data) do
            {
              "notification_setting_id": '',
              "group_type": 'account_group',
              "group_name": 'Group 1',
              "state": 'wrong_state'
            }
          end

          run_test! { |response| expect(response.status).to eq 404 }
        end

        context "Setting can't be blank" do
          let(:data) do
            {
              "notification_setting_id": '',
              "group_type": 'account_group',
              "group_name": 'Group 1',
              "state": 'active'
            }
          end
          schema type: :object,
                 properties: {
                   errors: {
                     type: :array,
                     items: {
                       type: :object
                     },
                     example: [
                       "name": 'Setting with id  doesnt exists'
                     ]
                   }
                 }

          run_test! { |response| expect(response.status).to eq 404 }
        end
      end
    end
  end

  path '/notifsettings/groups/{id}' do
    put 'notification_group' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_group', 'update'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :data, in: :body, schema: {
        type: :object,

        properties: {
          notification_setting_id: { type: :integer },
          group_type: { type: :string },
          group_name: { type: :string },
          state: { type: :string }

        },
        required: %w[notification_setting_id group_type group_name state]
      }

      let(:data) do
        {

          "group_name": 'Group 2',
          "state": 'active'
        }
      end
      context 'given  valid params' do
        let(:notification_group) { create :notification_group }
        let(:id) { notification_group.id }
        response '200', :success do
          schema '$ref' => '#/components/schemas/notification_group'
          run_test! { |response| expect(response.status).to eq 200 }
        end
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

      response '404', :unauthorized do
        context 'given invalid state' do
          let(:id) { 545_455_545_454 }

          run_test! { |response| expect(response.status).to eq 404 }
        end

        context "Setting can't be blank" do
          let(:data) do
            {
              "notification_setting_id": '',
              "group_type": 'account_group'

            }
          end
          schema type: :object,
                 properties: {
                   errors: {
                     type: :array,
                     items: {
                       type: :object
                     },
                     example: [
                       "name": 'Setting with id  doesnt exists'
                     ]
                   }
                 }

          run_test! { |response| expect(response.status).to eq 404 }
        end
      end
    end
  end

  path '/notifsettings/groups/{id}' do
    get 'notification_group' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_group', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true

      context 'given  valid params' do
        let(:notification_group) { create :notification_group }
        let(:id) { notification_group.id }
        response '200', :success do
          schema '$ref' => '#/components/schemas/notification_group'
          run_test! { |response| expect(response.status).to eq 200 }
        end
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

      response '404', :unauthorized do
        context 'given invalid state' do
          let(:id) { 545_455_545_454 }

          run_test! { |response| expect(response.status).to eq 404 }
        end

        context "Setting can't be blank" do
          let(:data) do
            {
              "notification_setting_id": '',
              "group_type": 'account_group'

            }
          end
          schema type: :object,
                 properties: {
                   errors: {
                     type: :array,
                     items: {
                       type: :object
                     },
                     example: [
                       "name": 'Setting with id  doesnt exists'
                     ]
                   }
                 }

          run_test! { |response| expect(response.status).to eq 404 }
        end
      end
    end
  end

  path '/notifsettings/groups' do
    get 'notification_group' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_group', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true

      context 'given  valid params' do
        let(:notification_setting) { create :notification_setting }
        let!(:notification_group) do
          create :notification_group, "notification_setting_id": notification_setting.id,
                                      "group_type": 'account_group',
                                      "group_name": 'Group 1',
                                      "state": 'active'
        end

        response '200', :success do
          run_test! { |response| expect(response.status).to eq 200 }
        end
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

  path '/notifsettings/groups/{id}' do
    delete 'notification_group' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'notification_group', 'delete'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true

      context 'given  valid params' do
        let(:notification_group) { create :notification_group }
        let(:id) { notification_group.id }
        response '200', :success do
          schema '$ref' => '#/components/schemas/notification_group'
          run_test! { |response| expect(response.status).to eq 200 }
        end
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

      response '404', :unauthorized do
        context 'given invalid state' do
          let(:id) { 545_455_545_454 }

          run_test! { |response| expect(response.status).to eq 404 }
        end

        context "Setting can't be blank" do
          let(:data) do
            {
              "notification_setting_id": '',
              "group_type": 'account_group'

            }
          end
          schema type: :object,
                 properties: {
                   errors: {
                     type: :array,
                     items: {
                       type: :object
                     },
                     example: [
                       "name": 'Setting with id  doesnt exists'
                     ]
                   }
                 }

          run_test! { |response| expect(response.status).to eq 404 }
        end
      end
    end
  end
end
