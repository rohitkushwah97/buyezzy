require 'swagger_helper'

RSpec.describe '/bx_block_favourites', :jwt do
  let(:current_user) { create(:account) }
  let(:favourite_user) { create(:account) }
  let(:favourite_user2) { create(:account) }

  let(:json) { JSON response.body }
  let(:errors) { json['errors'] }

  let(:id) { current_user.id }
  let(:token) { jwt }
  let(:headers) { { token: token } }

  path '/favourites/favourites/{favourite_id}' do
    delete 'Delete a Favourite' do
      tags 'bx_block_favourites', 'favourites', 'create'
      consumes 'application/json'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}'
      parameter name: :favourite_id, in: :path, type: :integer

      let(:favourite) do
        create(:favourite, user_id: current_user.id, favouriteable: favourite_user)
      end

      context 'destroy a favourite given a valid favourite id' do
        let(:favourite_id) { favourite.id }
        response '200', :success do
          schema '$ref' => '#/components/schemas/favourite'
          run_test! do |response|
            expect(json['message']).to eq 'Destroy successfully'
            expect(response.status).to eq 200
          end
        end
      end

      context 'given an invalid favourite id' do
        let(:favourite_id) { favourite.id + 100 }
        response '404', :not_found do
          schema '$ref' => '#/components/schemas/favourite_record_not_found'
          run_test! do |response|
            expect(errors[0]).to eq 'Record not found'
            expect(response.status).to eq 404
          end
        end
      end
    end
  end
end
