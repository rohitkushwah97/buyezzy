require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/help_centre/question_answer', :jwt do
  let(:token)   { jwt }
  let(:account) { create :email_account }
  let(:id)      { account.id }

  let!(:question_sub_type1) { create :question_sub_type }

  path '/help_centre/search_que_ans' do
    get 'Retrieves search result' do
      tags 'bx_block_help_centre', 'search_que_ans'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :query, in: :query, type: :string, example: "Question", required: true

      let!(:question_answer1) { create :question_answer, question_sub_type: question_sub_type1 }
      let(:query) { "Question" }

      response '200', 'search result found' do
        schema '$ref' => '#/components/schemas/question_answer'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data.count).to be >= 1
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end

      response "401", :expired do
        let(:token) { jwt_expired }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end
  end
end
