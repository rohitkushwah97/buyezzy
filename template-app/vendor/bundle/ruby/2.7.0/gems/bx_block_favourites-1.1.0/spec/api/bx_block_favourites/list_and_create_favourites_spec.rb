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

  path '/favourites/favourites' do
    post 'Create Favourites' do
      tags 'bx_block_favourites', 'favourites', 'create'
      consumes 'application/json'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              favouriteable_id: { type: :integer },
              favouriteable_type: { type: :string }
            }
          }
        },
        required: ['favouriteable_id', 'favouriteable_type']
      }

      let(:params) {
        {
          data: {
            favouriteable_id: favourite_user.id,
            favouriteable_type: favourite_user.class.name
          }
        }
      }

      context 'favourites the profile' do
        response '200', :success do
          schema '$ref' => '#/components/schemas/favourite'
          run_test! do |response|
            favourites =
              BxBlockFavourites::Favourite.where(
                user_id: current_user.id,
                favouriteable_id: favourite_user.id,
                favouriteable_type: favourite_user.class.name
              )
            expect(favourites.count).to eq 1
            expect(favourites.first.favouriteable).to eq(favourite_user)
            expect(response.status).to eq 200
          end
        end
      end

      context 'failure' do
        let(:params) {
          {
            data: {
              favouriteable_id: favourite_user.id,
              favouriteable_type: 'NonExisting'
            }
          }
        }

        context 'pass invalid attributes' do
          response '422', :unprocessable_entity do
            run_test! do
              expect(errors).to eq('uninitialized constant NonExisting')
              expect(response.status).to eq 422
            end
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

    get 'List Favourites' do
      tags 'bx_block_favourites', 'favourites', 'index'
      produces 'application/json'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}'
      let!(:favourite) do
        create(:favourite, user_id: current_user.id, favouriteable: favourite_user)
      end

      let!(:favourite2) do
        create(:favourite, user_id: current_user.id, favouriteable: favourite_user2)
      end

      context 'returns a list of favourites' do
        response '200', :success do
          schema '$ref' => '#/components/schemas/favourite'
          run_test! do
            expect(json['data'].count).to eq 2
            expect(json['data'][0]['attributes']['user_id']).to eq current_user.id
            expect(json['data'][0]['attributes']['favouriteable_id']).to eq favourite_user.id
            expect(json['data'][1]['attributes']['user_id']).to eq current_user.id
            expect(json['data'][1]['attributes']['favouriteable_id']).to eq favourite_user2.id
            expect(response.status).to eq 200
          end
        end
      end

      context 'pass invalid user' do
        let!(:favourite_user1) { create :account, email: 'test@yopmail.com', password: '123456' }
        let!(:token) { BuilderJsonWebToken.encode(favourite_user1.id) }
        response '404', :not_found do
          run_test! do
            expect(errors).to eq('Favourites not found')
            expect(response.status).to eq 404
          end
        end
      end

      response '400', :unauthorized do
        let(:token) { '' }
        run_test!
      end
    end
  end
end
