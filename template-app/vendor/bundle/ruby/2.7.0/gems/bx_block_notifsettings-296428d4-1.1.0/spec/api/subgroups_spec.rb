# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/notifsettings', :jwt do
  let(:data)   { json['data'] }
  let(:token)  { jwt }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }
  let(:model_errors) { data['attributes']['errors'] }
  let(:model_error)  { errors.first }

  let(:account) { create :email_account }
  let(:id)      { account.id }
  let(:notification_group) { create :notification_group }

  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: 'login') }
  let(:id)      { account.id }

  path '/notifsettings/subgroups' do
    post 'subgroups' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'subgroups', 'create'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :data, in: :body, schema: {
        type: :object,

        properties: {
          notification_group_id: { type: :integer },
          subgroup_type: { type: :string },
          subgroup_name: { type: :string },
          state: { type: :string }

        },
        required: %w[notification_group_id subgroup_type subgroup_name state]
      }

      let(:data) do
        {
          "notification_group_id": notification_group.id,
          "subgroup_type": 'wishlist_item_out_of_stock',
          "subgroup_name": 'sub Group 1',
          "state": 'active'
        }
      end

      response '201', :success do
        schema '$ref' => '#/components/schemas/notification_subgroups'
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

  path '/notifsettings/subgroups/{id}' do
    put 'subgroups' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'subgroups', 'update'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :data, in: :body, schema: {
        type: :object,

        properties: {
          notification_group_id: { type: :integer },
          subgroup_type: { type: :string },
          subgroup_name: { type: :string },
          state: { type: :string }

        },
        required: %w[notification_group_id subgroup_type subgroup_name state]
      }

      let(:notification_subgroup) { create :notification_subgroup }
      let(:id) { notification_subgroup.id }

      let(:data) do
        {
          "notification_group_id": notification_group.id,
          "subgroup_type": 'wishlist_item_out_of_stock',
          "subgroup_name": 'sub Group 2222',
          "state": 'active'
        }
      end

      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_subgroups'
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

  path '/notifsettings/subgroups/{id}' do
    get 'subgroups' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'subgroups', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true
      let(:notification_subgroup) { create :notification_subgroup }
      let(:id) { notification_subgroup.id }
      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_subgroups'
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

  path '/notifsettings/subgroups' do
    get 'subgroups' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'subgroups', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      #   parameter name: :id, in: :path, type: :string, required: true
      let(:notification_subgroup) { create :notification_subgroup }
      # let(:id) { notification_subgroup.id }
      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_subgroups'
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

  path '/notifsettings/subgroups/{id}' do
    delete 'subgroups' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_notifsettings', 'subgroups', 'index'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :string, required: true

      let(:notification_subgroup) { create :notification_subgroup }
      let(:id) { notification_subgroup.id }
      response '200', :success do
        schema '$ref' => '#/components/schemas/notification_subgroups'
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
