# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/bx_block_reviews', :jwt do
  let(:json) { JSON response.body }
  let(:data) { json['data'] }
  let(:token) { jwt }
  let(:attributes) { data['attributes'] }
  let(:errors) { json['errors'] }
  let(:error) { errors.first }
  let(:model_errors) { data['attributes']['errors'] }
  let(:model_error) { errors.first }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: 'login') }

  let(:account) { create :account }
  let(:id) { account.id }
  let(:review) { FactoryBot.create(:reviews_review) }

  let(:review_params) do
    { 'data' =>
        {
          'attributes' => {
            'title' => review.title,
            'description' => review.description,
            :account_id => account.id,
            :anonymous => true
          }
        } }
  end

  let(:update_params) do
    { 'data' =>
        {
          'attributes' => {
            'title' => review.title,
            'description' => review.description
          }
        } }
  end

  path '/reviews/reviews' do
    post 'Create Review' do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_reviews', 'reviews', 'create'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              title: { type: :string, nullable: true, example: '1' },
              description: { type: :string, nullable: true, example: '1' },
              account_id: { type: :integer, nullable: true, example: '1' },
              anonymous: { type: :boolean, nullable: false, example: 'true' }
            }
          }
        }
      }

      let(:params) { review_params }
      response '201', :success do
        schema '$ref' => '#/components/schemas/review'

        context 'Should have status 201' do
          run_test! do |response|
            expect(response.status).to eq 201
          end
        end

        context 'Should have same response description' do
          run_test! do |response|
            json_response = JSON.parse(response.body)
            expect(json_response['data']['attributes']['title']).to eq review.description
          end
        end
      end

      response '422', :unprocessable_entity do
        let(:params) do
          { 'data' =>
              {

                'title' => review.title,
                'description' => review.description,
                :account_id => account.id,
                :anonymous => true

              } }
        end

        context 'Error with review params' do
          run_test!
        end
      end

      response '400', :unauthorized do
        let(:token) { '' }

        run_test!
      end

      response '401', :unauthorized do
        let(:token) { jwt_expired }

        run_test!
      end
    end
  end
end   