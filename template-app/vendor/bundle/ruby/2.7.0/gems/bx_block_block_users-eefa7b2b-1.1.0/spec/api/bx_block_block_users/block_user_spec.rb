require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/block_user', :jwt do
  let(:token)  { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let(:jwt_expired) { BuilderJsonWebToken.encode(account.id, 1.day.ago, token_type: "login") }

  let(:account) { create :email_account, first_name: "test_username1" }
  let(:account2) { create :email_account, first_name: "test_username2" }
  let(:account3) { create :email_account, first_name: "test_username3" }

  path '/block_users/block_users' do
    get 'Retrieves list of blocked users' do
      tags 'bx_block_block_users', 'block_users', 'index'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      let!(:block_user1) { create :block_user, account_id: account2.id, current_user_id: account.id }

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/block_user'

        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data.count).to eq 1
          expect(data.map { |d| d["attributes"]["account_id"]}.sort).to eq [account2.id].sort
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

    post 'Block user' do
      tags 'bx_block_block_users', 'block_users', 'create'
      produces "application/json"
      consumes "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  account_id: { type: :string, example: "test_username2" }
                }
              }
            }
          }
        }
      }

      response '201', 'success' do
        let(:params) do
          {
            data: {
              attributes: {
                account_id: account2.id
              }
            }
          }
        end

        schema '$ref' => '#/components/schemas/block_user'

        run_test! do |response|
          expect(response.status).to eq 201

          data = JSON.parse(response.body)['data']

          expect(BxBlockBlockUsers::BlockUser.count).to eq 1

          expect(data["attributes"]["account_id"]).to eq account2.id
        end
      end

      response '422', 'block yourself' do
        let(:params) do
          {
            data: {
              attributes: {
                account_id: account.id
              }
            }
          }
        end

        schema '$ref' => '#/components/schemas/block_user'

        run_test! do |response|
          expect(response.status).to eq 422

          data = JSON.parse(response.body)

          expect(data["errors"][0]["message"]).to eq "You cannot block yourself."
        end
      end

      response '422', 'user not exist' do
        let(:params) do
          {
            data: {
              attributes: {
                account_id: "username_not_exists"
              }
            }
          }
        end

        schema '$ref' => '#/components/schemas/block_user'

        run_test! do |response|
          expect(response.status).to eq 422

          data = JSON.parse(response.body)

          expect(data["errors"][0]["message"]).to eq "User does not exist."
        end
      end

      response '422', 'user already blocked' do
        let(:params) do
          {
            data: {
              attributes: {
                account_id: account2.id
              }
            }
          }
        end
        let!(:block_user1) { create :block_user, account_id: account2.id, current_user_id: account.id }

        schema '$ref' => '#/components/schemas/block_user'

        run_test! do |response|
          expect(response.status).to eq 422

          data = JSON.parse(response.body)

          expect(data["errors"][0]["message"]).to eq "User already blocked."
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        let(:params) do
          {
            data: {
              attributes: {
                account_id: account2.id
              }
            }
          }
        end

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
        let(:params) do
          {
            data: {
              attributes: {
                account_id: account2.id
              }
            }
          }
        end

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

  path '/block_users/block_users/{id}' do
    get 'Get block user' do
      tags 'bx_block_block_users', 'block_users', 'show'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :string, example: "{{bx_blocks_api_token}}", required: true

      let!(:block_user1) { create :block_user, account_id: account2.id, current_user_id: account.id }
      let(:id) { account2.id }

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/block_user'

        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data['attributes']['current_user_id']).to eq account.id
          expect(data['attributes']['account_id']).to eq account2.id
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

    delete 'Unblock user' do
      tags 'bx_block_block_users', 'block_users', 'delete'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :string, example: "{{bx_blocks_api_token}}", required: true

      let!(:block_user1) { create :block_user, account_id: account2.id, current_user_id: account.id }
      let(:id) { block_user1.id }

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/block_user'

        run_test! do |response|
          expect(response.status).to eq 200

          json = JSON.parse(response.body)
          expect(json['message']).to eq "User unblocked."
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
