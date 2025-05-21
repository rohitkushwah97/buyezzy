# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/payment_admin', :jwt do
  let(:json) { JSON response.body }

  let(:account) { create :email_account, user_name: 'Test User Notification' }
  let(:account2) { create :email_account, user_name: 'Test User' }
  let(:id) { account.id }
  let!(:payment_admin1) { create :payment_admin, account: account2, current_user_id: account.id }
  let!(:payment_admin2) { create :payment_admin, account: account2, current_user_id: account.id }
  let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: 'login') }

  path '/payment_admin/payment_admin/' do
    get 'payment_admin' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_documentation', 'document', 'create'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :type, in: :query, type: :string

      let(:type) { 'credit' }

      response '200', :success do
        schema '$ref' => '#/components/schemas/payment_admin'
        run_test!
      end

      response '422', :unauthorized do
        context "type can't be blank" do
          let(:account) { create :email_account, user_name: 'Test User Notification' }
          let(:account2) { create :email_account, user_name: 'Test User' }
          let(:id)      { account.id }
          let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: 'login') }
          let(:data) do
            {
              data: {
                attributes: {
                  type: ''
                }
              }
            }
          end

          run_test! { |response| expect(response.status).to eq 422 }
        end
      end
    end
  end

  path '/payment_admin/payment_admin/{id}' do
    let(:account) { create :email_account, user_name: 'Test User Notification' }
    let(:account2) { create :email_account, user_name: 'Test User' }
    let(:id) { account.id }
    let!(:payment_admin1) { create :payment_admin, account: account2, current_user_id: account.id }
    let!(:payment_admin2) { create :payment_admin, account: account2, current_user_id: account.id }
    let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: 'login') }

    get 'show payment' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_documentation', 'document', 'create'
      parameter name: :token, in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :id, in: :path, type: :integer
      let(:id) { payment_admin2.id }

      response '200', :success do
        schema '$ref' => '#/components/schemas/payment_admin'
        run_test!
      end
    end
  end
end
